# PRIVATE CLASS - do not use directly
class ospuppet::agent::config::settings {

  $certname          = $::ospuppet::agent::certname
  $server            = $::ospuppet::agent::server
  $ca_server         = $::ospuppet::agent::ca_server
  $report            = $::ospuppet::agent::report
  $report_server     = $::ospuppet::agent::report_server
  $environment       = $::ospuppet::agent::environment
  $priority          = $::ospuppet::agent::priority
  $usecacheonfailure = $::ospuppet::agent::usecacheonfailure
  $runinterval       = $::ospuppet::agent::runinterval
  $waitforcert       = $::ospuppet::agent::waitforcert
  $daemonize         = $::ospuppet::agent::daemonize
  $custom_settings   = $::ospuppet::agent::custom_settings

  if $ca_server {
    $ensure_ca_server = 'present'
  } else {
    $ensure_ca_server = 'absent'
  }

  if $report_server {
    $ensure_report_server = 'present'
  } else {
    $ensure_report_server = 'absent'
  }

  if $priority {
    $ensure_priority = 'present'
  } else {
    $ensure_priority = 'absent'
  }

  $default_settings = {
    "${name}.agent.certname" => {
      'ensure'  => 'absent',
      'setting' => 'certname',
    },
    "${name}.agent.server" => {
      'ensure'  => 'absent',
      'setting' => 'server',
    },
    "${name}.agent.ca_server" => {
      'ensure'  => 'absent',
      'setting' => 'ca_server',
    },
    "${name}.agent.report" => {
      'setting' => 'report',
      'value'   => $report,
    },
    "${name}.agent.report_server" => {
      'ensure'  => 'absent',
      'setting' => 'report_server',
    },
    "${name}.agent.environment" => {
      'ensure'  => 'absent',
      'setting' => 'environment',
    },
    "${name}.agent.priority" => {
      'ensure'  => $ensure_priority,
      'setting' => 'priority',
      'value'   => $priority,
    },
    "${name}.agent.usecacheonfailure" => {
      'setting' => 'usecacheonfailure',
      'value'   => $usecacheonfailure,
    },
    "${name}.agent.runinterval" => {
      'setting' => 'runinterval',
      'value'   => $runinterval,
    },
    "${name}.agent.waitforcert" => {
      'setting' => 'waitforcert',
      'value'   => $waitforcert,
    },
    "${name}.agent.daemonize" => {
      'setting' => 'daemonize',
      'value'   => $daemonize,
    },
  }

  $agent_settings = merge(
    $default_settings,
    $custom_settings,
  )

  $main_settings = {
    "${name}.main.certname" => {
      'setting' => 'certname',
      'value'   => $certname,
    },
    "${name}.main.environment" => {
      'setting' => 'environment',
      'value'   => $environment,
    },
    "${name}.main.server" => {
      'setting' => 'server',
      'value'   => $server,
    },
    "${name}.main.ca_server" => {
      'ensure'  => $ensure_ca_server,
      'setting' => 'ca_server',
      'value'   => $ca_server,
    },
    "${name}.main.report_server" => {
      'ensure'  => $ensure_report_server,
      'setting' => 'report_server',
      'value'   => $report_server,
    },
  }

  create_resources(::ospuppet::config::main_config::main, $main_settings)
  create_resources(::ospuppet::config::main_config::agent, $agent_settings)

}
