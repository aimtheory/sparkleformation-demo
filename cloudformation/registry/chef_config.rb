# Registry: chef_config
# Description: Some commands to install and configure Chef as defined in an
# AWS::AutoScalingGroup::LaunchConfiguration resource. This registry
# needs to be inserted into such a resource in order to work properly.
SparkleFormation::Registry.register(:chef_config) do |_name, _config={}|
  metadata('AWS::CloudFormation::Init') do
    _camel_keys_set(:auto_disable)
    config do
      commands('03_install_chef_client') do
        command 'sudo curl -L https://www.chef.io/chef/install.sh | bash -s -- -v 12'
        test 'test ! -d "/var/chef"'
      end
      commands('04_download_chef_config') do
        command 'sudo aws s3 cp s3://fortis-chef-config/chef_config.sh'
        test 'test ! -f "chef_config.sh"'
      end
      commands('05_build_chef_config') do
        command 'sudo bash chef_config.sh'
        test 'test ! -d "/etc/chef"'
      end
      commands('06_build_first_boot') do
        command "sudo echo {'run_list':#{_config[:run_list]}} > /etc/first-boot.json"
        test 'test ! -f "/etc/chef/first-boot.json"'
      end
      commands('07_chef_log_dir') do
        command "sudo mkdir -p /var/log/chef"
        test 'test ! -d "/var/log/chef"'
      end
      commands('99_run_chef_client') do
        command "sudo chef-client -j /etc/chef/first-boot.json"
        test 'test ! -f "/etc/chef/chef-validator.pem"'
      end
    end
  end
end
