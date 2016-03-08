# Registry: chef_config
# Description: Some commands to install and configure Chef as defined in an
# AWS::AutoScalingGroup::LaunchConfiguration resource. This registry
# needs to be inserted into such a resource in order to work properly.
SparkleFormation::Registry.register(:chef_config) do |_name, _config={}|
  metadata('AWS::CloudFormation::Init') do
    _camel_keys_set(:auto_disable)
    config do
      files('/etc/chef/first_run.json') do
        content do
          run_list _config[:run_list] ? _config[:run_list] : ref!("#{_name}_run_list".to_sym)
          stack do
            name ref!('AWS::StackName')
            id ref!('AWS::StackId')
            region ref!('AWS::Region')
            creator ref!(:creator)
          end
        end
        mode '000644'
        owner 'root'
        group 'root'
      end
      files('/etc/chef/client.rb') do
        content join!(
          "log_level :info\n",
          "log_location '/var/log/chef/client.log'\n",
          "chef_server_url 'https://YOUR_CHEF_SERVER_URL:443'\n",
          "environment '",
          ref!(:environment),
          "'\n",
          "validation_key '/etc/chef/chef-validator.pem'\n",
          "validation_client_name 'chef-validator'\n"
        )
        mode '000644'
        owner 'root'
        client 'root'
      end
      commands('00_install_chef_client') do
        command 'rpm -ivh https://opscode-omnibus-packages.s3.amazonaws.com/el/6/x86_64/chef-12.7.2-1.el6.x86_64.rpm > /var/log/chef_install.log'
        test 'test ! -d /var/chef'
      end
      commands('01_ohai_hints') do
        command 'mkdir -p /etc/chef/ohai/hints && touch /etc/chef/ohai/hints/ec2.json'
        test 'test ! -f /etc/chef/ohai/hints/ec2.json'
      end
      commands('03_chef_log_dir') do
        command 'mkdir -p /var/log/chef'
        test 'test ! -d "/var/log/chef"'
      end
      commands('04_mkdir_etc_chef') do
        command 'mkdir -p /etc/chef/trusted_certs'
        test 'test ! -d /etc/chef'
      end
      commands('05_cp_chef_server_crt') do
        command 'aws s3 cp s3://YOUR_S3_BUCKET/YOUR_CHEF_SERVER_CERT.crt /etc/chef/trusted_certs/YOUR_CHEF_SERVER_CERT.crt'
        test 'test ! -f /etc/chef/YOUR_CHEF_SERVER_CERT.crt'
      end
      commands('06_cp_chef_validator') do
        command 'aws s3 cp s3://YOUR_S3_BUCKET/chef-validator.pem /etc/chef/chef-validator.pem'
        test 'test ! -f /etc/chef/chef-validator.pem'
      end
      commands('07_cp_data_bag_secret') do
        command 'aws s3 cp s3://YOUR_S3_BUCKET/encrypted_data_bag_secret /etc/chef/encrypted_data_bag_secret'
        test 'test ! -f /etc/chef/encrypted_data_bag_secret'
      end
      commands('08_set_node_name') do
        command join!('echo "node_name ', "'`hostname`.ec2.internal.YOURDOMAINNAME.com'", '" >> /etc/chef/client.rb')
      end
      commands('99_run_chef_client') do
        command "chef-client -j /etc/chef/first_run.json"
        test 'test -e "/etc/chef/chef-validator.pem"'
      end
    end
  end
end
