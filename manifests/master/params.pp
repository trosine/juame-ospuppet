# PRIVATE CLASS - do not use directly
class ospuppet::master::params {

  $puppet_user                 = 'puppet'
  $puppet_group                = 'puppet'
  $puppet_gem_provider         = 'puppet_gem'
  $puppetserver_gem_provider   = 'puppetserver_gem'
  $hiera_config                = '/etc/puppetlabs/code/hiera.yaml'
  $hiera_backends              = [ 'yaml', 'eyaml' ]
  $hiera_hierarchy             = [
    'secure/nodes/%{::clientcert}',
    'secure/services/%{::service}/%{::stage}/%{::role}',
    'nodes/%{::clientcert}',
    'services/%{::service}/%{::stage}/%{::role}',
    'services/%{::service}/%{::stage}',
    'services/%{::service}/%{::role}',
    'services/%{::service}',
    'locations/%{::location}',
    'common',
  ]
  $hiera_yaml_datadir          = '/etc/puppetlabs/code/environments/%{environment}/hieradata'
  $hiera_merge_package_name    = 'deep_merge'
  $hiera_merge_package_version = 'latest'
  $hiera_merge_behavior        = 'deeper'
  $hiera_logger                = 'noop'
  $hiera_eyaml_package_name    = 'hiera-eyaml'
  $hiera_eyaml_package_version = 'latest'
  $hiera_eyaml_extension       = 'eyaml'
  $hiera_eyaml_key_dir         = '/etc/puppetlabs/puppet/keys'
  $hiera_eyaml_private_key     = 'private_key.pkcs7.pem'
  $hiera_eyaml_public_key      = 'public_key.pkcs7.pem'

}
