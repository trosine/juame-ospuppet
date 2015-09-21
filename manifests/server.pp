# Class to configure a Puppet Server. See README.md for more details.
class ospuppet::server (
  $package_name                        = 'puppetserver',
  $ensure_installed                    = true,
  $package_version                     = 'latest',
  $service_name                        = 'puppetserver',
  $service_running                     = true,
  $service_enabled                     = true,
  $service_manage_master               = false,
  $config_dir                          = '/etc/puppetlabs/puppetserver/conf.d',
  $init_settings_config                = $::ospuppet::server::params::init_settings_config,
  $init_settings_java_bin              = '/usr/bin/java',
  $init_settings_java_xms              = '512m',
  $init_settings_java_xmx              = '512m',
  $init_settings_java_maxpermsize      = '256m',
  $init_settings_user                  = 'puppet',
  $init_settings_group                 = 'puppet',
  $init_settings_install_dir           = '/opt/puppetlabs/server/apps/puppetserver',
  $init_settings_bootstrap_config      = '/etc/puppetlabs/puppetserver/bootstrap.cfg',
  $init_settings_service_stop_retries  = 60,
  $init_settings_custom_settings       = {},
  $init_settings_custom_subsettings    = {},
  $puppetserver_ruby_load_path         = ['/opt/puppetlabs/puppet/lib/ruby/vendor_ruby'],
  $puppetserver_gem_home               = '/opt/puppetlabs/server/data/puppetserver/jruby-gems',
  $puppetserver_master_conf_dir        = '/etc/puppetlabs/puppet',
  $puppetserver_master_code_dir        = '/etc/puppetlabs/code',
  $puppetserver_master_var_dir         = '/opt/puppetlabs/server/data/puppetserver',
  $puppetserver_master_run_dir         = '/var/run/puppetlabs/puppetserver',
  $puppetserver_master_log_dir         = '/var/log/puppetlabs/puppetserver',
  $puppetserver_max_active_instances   = undef,
  $puppetserver_profiler_enabled       = false,
  $puppetserver_admin_client_whitelist = [],
  $puppetserver_custom_settings        = {},
  $webserver_access_log_config         = '/etc/puppetlabs/puppetserver/request-logging.xml',
  $webserver_client_auth               = 'want',
  $webserver_ssl_host                  = '0.0.0.0',
  $webserver_ssl_port                  = '8140',
  $webserver_custom_settings           = {},
) inherits ::ospuppet::server::params {

  include ospuppet

  validate_bool(
    $ensure_installed,
    $service_enabled,
    $service_running,
    $service_manage_master,
    $puppetserver_profiler_enabled,
  )

  validate_string(
    $package_name,
    $package_version,
    $init_settings_java_xms,
    $init_settings_java_xmx,
    $init_settings_java_maxpermsize,
    $init_settings_user,
    $init_settings_group,
    $service_name,
    $webserver_client_auth,
    $webserver_ssl_host,
    $webserver_ssl_port,
  )

  validate_absolute_path(
    $init_settings_config,
    $init_settings_java_bin,
    $init_settings_install_dir,
    $config_dir,
    $init_settings_bootstrap_config,
    $puppetserver_ruby_load_path,
    $puppetserver_gem_home,
    $puppetserver_master_conf_dir,
    $puppetserver_master_code_dir,
    $puppetserver_master_var_dir,
    $puppetserver_master_run_dir,
    $puppetserver_master_log_dir,
    $webserver_access_log_config,
  )

  validate_array(
    $puppetserver_admin_client_whitelist,
    $puppetserver_ruby_load_path,
  )

  validate_hash(
    $init_settings_custom_settings,
    $init_settings_custom_subsettings,
    $puppetserver_custom_settings,
    $webserver_custom_settings,
  )

  validate_numeric($init_settings_service_stop_retries)
  if $puppetserver_max_active_instances {
    validate_numeric($puppetserver_max_active_instances)
  }

  validate_re($init_settings_java_xms, '^\d+(?:.\d+)?(?:m|g)$')
  validate_re($init_settings_java_xmx, '^\d+(?:.\d+)?(?:m|g)$')
  validate_re($init_settings_java_maxpermsize, '^\d+(?:.\d+)?(?:m|g)$')
  validate_re($webserver_client_auth, '^(need|want|none)$')

  Class[ospuppet::server::install] -> Class[ospuppet::server::config]
  Class[ospuppet::server::config] ~> Class[ospuppet::server::service]

  contain ospuppet::server::install
  contain ospuppet::server::config
  contain ospuppet::server::service

}
