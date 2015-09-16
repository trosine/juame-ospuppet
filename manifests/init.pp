# Class to configure the open source Puppet components. See README.md for more details.
class ospuppet (
  $puppet_user                 = $::ospuppet::params::puppet_user,
  $puppet_group                = $::ospuppet::params::puppet_group,
  $puppet_confdir              = $::ospuppet::params::puppet_confdir,
  $puppet_config               = $::ospuppet::params::puppet_config,
  $puppet_gem_provider         = $::ospuppet::params::puppet_gem_provider,
  $package_name                = $::ospuppet::params::package_name,
  $package_version             = $::ospuppet::params::package_version,
  $agent_service_name          = $::ospuppet::params::agent_service_name,
  $agent_service_running       = $::ospuppet::params::agent_service_running,
  $agent_service_enabled       = $::ospuppet::params::agent_service_enabled,
  $agent_init_settings_config  = $::ospuppet::params::agent_init_settings_config,
  $agent_certname              = $::ospuppet::params::agent_certname,
  $agent_server                = $::ospuppet::params::agent_server,
  $agent_ca_server             = $::ospuppet::params::agent_ca_server,
  $agent_report                = $::ospuppet::params::agent_report,
  $agent_report_server         = $::ospuppet::params::agent_report_server,
  $agent_environment           = $::ospuppet::params::agent_environment,
  $agent_priority              = $::ospuppet::params::agent_priority,
  $agent_usecacheonfailure     = $::ospuppet::params::agent_usecacheonfailure,
  $agent_runinterval           = $::ospuppet::params::agent_runinterval,
  $agent_waitforcert           = $::ospuppet::params::agent_waitforcert,
  $agent_daemonize             = $::ospuppet::params::agent_daemonize,
  $agent_custom_settings       = $::ospuppet::params::agent_custom_settings,
) inherits ::ospuppet::params {

  validate_string(
    $puppet_user,
    $puppet_group,
    $puppet_config,
    $puppet_gem_provider,
    $package_name,
    $package_version,
    $agent_service_name,
    $agent_certname,
    $agent_server,
    $agent_environment,
    $agent_runinterval,
    $agent_waitforcert,
  )

  if $agent_ca_server {
    validate_string($agent_ca_server)
  }

  if $agent_report_server {
    validate_string($agent_report_server)
  }

  if $agent_priority {
    validate_integer($agent_priority)
  }

  validate_bool(
    $agent_service_running,
    $agent_service_enabled,
    $agent_report,
    $agent_usecacheonfailure,
    $agent_daemonize,
  )

  validate_absolute_path(
    $puppet_confdir,
    $agent_init_settings_config,
  )

  validate_hash($agent_custom_settings)
  validate_re($agent_runinterval, '^\d+(?:.\d+)?(?:s|m|h|d|y)$')
  validate_re($agent_waitforcert, '^\d+(?:.\d+)?(?:s|m|h|d|y)$')

  Class[ospuppet::agent::install] -> Class[ospuppet::agent::config::settings]
  Class[ospuppet::agent::config::settings] ~> Class[ospuppet::agent::service]

  contain ospuppet::agent::install
  contain ospuppet::agent::config::settings
  contain ospuppet::agent::service

}
