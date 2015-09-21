# Class to configure a Puppet Agent. See README.md for more details.
class ospuppet::agent (
  $package_name                     = $::ospuppet::agent::params::package_name,
  $package_version                  = $::ospuppet::agent::params::package_version,
  $service_name                     = $::ospuppet::agent::params::service_name,
  $service_running                  = $::ospuppet::agent::params::service_running,
  $service_enabled                  = $::ospuppet::agent::params::service_enabled,
  $init_settings_config             = $::ospuppet::agent::params::init_settings_config,
  $init_settings_custom_settings    = {},
  $init_settings_custom_subsettings = {},
  $certname                         = $::ospuppet::agent::params::certname,
  $server                           = $::ospuppet::agent::params::server,
  $ca_server                        = $::ospuppet::agent::params::ca_server,
  $report                           = $::ospuppet::agent::params::report,
  $report_server                    = $::ospuppet::agent::params::report_server,
  $environment                      = $::ospuppet::agent::params::environment,
  $priority                         = $::ospuppet::agent::params::priority,
  $usecacheonfailure                = $::ospuppet::agent::params::usecacheonfailure,
  $runinterval                      = $::ospuppet::agent::params::runinterval,
  $waitforcert                      = $::ospuppet::agent::params::waitforcert,
  $daemonize                        = $::ospuppet::agent::params::daemonize,
  $custom_settings                  = $::ospuppet::agent::params::custom_settings,
) inherits ::ospuppet::agent::params {

  require ospuppet

  validate_string(
    $package_name,
    $package_version,
    $service_name,
    $certname,
    $server,
    $environment,
    $runinterval,
    $waitforcert,
  )

  if $ca_server {
    validate_string($ca_server)
  }

  if $report_server {
    validate_string($report_server)
  }

  if $priority {
    validate_integer($priority)
  }

  validate_bool(
    $service_running,
    $service_enabled,
    $report,
    $usecacheonfailure,
    $daemonize,
  )

  validate_absolute_path(
    $init_settings_config,
  )

  validate_hash(
    $custom_settings,
    $init_settings_custom_settings,
    $init_settings_custom_subsettings,
  )

  validate_re($runinterval, '^\d+(?:.\d+)?(?:s|m|h|d|y)$')
  validate_re($waitforcert, '(^\d+(?:.\d+)?(?:s|m|h|d|y)$|^0$)')

  Class[ospuppet::agent::install] -> Class[ospuppet::agent::config]
  Class[ospuppet::agent::config] ~> Class[ospuppet::agent::service]

  contain ospuppet::agent::install
  contain ospuppet::agent::config
  contain ospuppet::agent::service

}
