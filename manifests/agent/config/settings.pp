# PRIVATE CLASS - do not use directly
class ospuppet::agent::config::settings {

  $puppet_confdir          = $::ospuppet::puppet_confdir
  $puppet_config           = $::ospuppet::puppet_config
  $agent_certname          = $::ospuppet::agent_certname
  $agent_server            = $::ospuppet::agent_server
  $agent_ca_server         = $::ospuppet::agent_ca_server
  $agent_report            = $::ospuppet::agent_report
  $agent_report_server     = $::ospuppet::agent_report_server
  $agent_environment       = $::ospuppet::agent_environment
  $agent_priority          = $::ospuppet::agent_priority
  $agent_usecacheonfailure = $::ospuppet::agent_usecacheonfailure
  $agent_runinterval       = $::ospuppet::agent_runinterval
  $agent_waitforcert       = $::ospuppet::agent_waitforcert
  $agent_daemonize         = $::ospuppet::agent_daemonize
  $agent_custom_settings   = $::ospuppet::agent_custom_settings

  if $agent_ca_server {
    $ensure_agent_ca_server = 'present'
  } else {
    $ensure_agent_ca_server = 'absent'
  }

  if $agent_report_server {
    $ensure_agent_report_server = 'present'
  } else {
    $ensure_agent_report_server = 'absent'
  }

  if $agent_priority {
    $ensure_agent_priority = 'present'
  } else {
    $ensure_agent_priority = 'absent'
  }

  $agent_default_settings = {
    "${name}.agent_certname" => {
      'setting' => 'certname',
      'value'   => $agent_certname,
    },
    "${name}.agent_server" => {
      'setting' => 'server',
      'value'   => $agent_server,
    },
    "${name}.agent_ca_server" => {
      'ensure'  => $ensure_agent_ca_server,
      'setting' => 'ca_server',
      'value'   => $agent_ca_server,
    },
    "${name}.agent_report" => {
      'setting' => 'report',
      'value'   => $agent_report,
    },
    "${name}.agent_report_server" => {
      'ensure'  => $ensure_agent_report_server,
      'setting' => 'report_server',
      'value'   => $agent_report_server,
    },
    "${name}.agent_environment" => {
      'setting' => 'environment',
      'value'   => $agent_environment,
    },
    "${name}.agent_priority" => {
      'ensure'  => $ensure_agent_priority,
      'setting' => 'priority',
      'value'   => $agent_priority,
    },
    "${name}.agent_usecacheonfailure" => {
      'setting' => 'usecacheonfailure',
      'value'   => $agent_usecacheonfailure,
    },
    "${name}.agent_runinterval" => {
      'setting' => 'runinterval',
      'value'   => $agent_runinterval,
    },
    "${name}.agent_waitforcert" => {
      'setting' => 'waitforcert',
      'value'   => $agent_waitforcert,
    },
    "${name}.agent_daemonize" => {
      'setting' => 'daemonize',
      'value'   => $agent_daemonize,
    },
  }

  $agent_settings = merge(
    $agent_default_settings,
    $agent_custom_settings,
  )

  $defaults = {
    'ensure'            => present,
    'section'           => 'agent',
    'key_val_separator' => ' = ',
    'path'              => "${$puppet_confdir}/${puppet_config}",
  }

  create_resources(ini_setting, $agent_settings, $defaults)

}
