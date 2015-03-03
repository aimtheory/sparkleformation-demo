log_level                :info
log_location             STDOUT
node_name                'ianrossi'
client_key               'ianrossi.pem'
validation_client_name   'chef-validator'
validation_key           'validation.pem'
chef_server_url          'https://chef-server'
syntax_check_cache_path  '/home/ianrossi/aimtheory/dev/chef-demo/.chef/syntax_check_cache'

knife[:aws_access_key_id] = 'AKIAJWWOWRZ7S2TNK2GA'
knife[:aws_secret_access_key] = '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'
knife[:region] = 'us-east-1'

[:cloudformation, :options].inject(knife){ |m,k| m[k] ||= Mash.new }
knife[:cloudformation][:options][:disable_rollback] = true
knife[:cloudformation][:options][:capabilities] = ['CAPABILITY_IAM']
knife[:cloudformation][:processing] = true
knife[:cloudformation][:credentials] = {
  :aws_region => knife[:region],
  :aws_access_key_id => knife[:aws_access_key_id],
  :aws_secret_access_key => knife[:aws_secret_access_key]
}
# If you are using nested stacks add bucket to store templates. Note
# that the bucket must exist (the library will not auto-create it)
knife[:cloudformation][:nesting_bucket] = 'my-cfn-nested-stacks'
