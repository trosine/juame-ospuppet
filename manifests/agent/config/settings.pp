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
    "${name}.certname" => {
      'setting' => 'certname',
      'value'   => $certname,
    },
    "${name}.server" => {
      'setting' => 'server',
      'value'   => $server,
    },
    "${name}.ca_server" => {
      'ensure'  => $ensure_ca_server,
      'setting' => 'ca_server',
      'value'   => $ca_server,
    },
    "${name}.report" => {
      'setting' => 'report',
      'value'   => $report,
    },
    "${name}.report_server" => {
      'ensure'  => $ensure_report_server,
      'setting' => 'report_server',
      'value'   => $report_server,
    },
    "${name}.environment" => {
      'setting' => 'environment',
      'value'   => $environment,
    },
    "${name}.priority" => {
      'ensure'  => $ensure_priority,
      'setting' => 'priority',
      'value'   => $priority,
    },
    "${name}.usecacheonfailure" => {
      'setting' => 'usecacheonfailure',
      'value'   => $usecacheonfailure,
    },
    "${name}.runinterval" => {
      'setting' => 'runinterval',
      'value'   => $runinterval,
    },
    "${name}.waitforcert" => {
      'setting' => 'waitforcert',
      'value'   => $waitforcert,
    },
    "${name}.daemonize" => {
      'setting' => 'daemonize',
      'value'   => $daemonize,
    },
  }

  $settings = merge(
    $default_settings,
    $custom_settings,
  )

  create_resources(::ospuppet::config::main_config::agent, $settings)

}
