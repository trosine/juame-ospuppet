# PRIVATE CLASS - do not use directly
class ospuppet::master::config::settings {

  $puppet_confdir    = $::ospuppet::puppet_confdir
  $puppet_config     = $::ospuppet::puppet_config
  $vardir            = $::ospuppet::master::vardir
  $logdir            = $::ospuppet::master::logdir
  $rundir            = $::ospuppet::master::rundir
  $pidfile           = $::ospuppet::master::pidfile
  $puppet_codedir    = $::ospuppet::puppet_codedir
  $custom_settings   = $::ospuppet::master::custom_settings

  $default_settings = {
    "${name}.master.vardir" => {
      'setting' => 'vardir',
      'value'   => $vardir,
    },
    "${name}.master.logdir" => {
      'setting' => 'logdir',
      'value'   => $logdir,
    },
    "${name}.master.rundir" => {
      'setting' => 'rundir',
      'value'   => $rundir,
    },
    "${name}.master.pidfile" => {
      'setting' => 'pidfile',
      'value'   => $pidfile,
    },
    "${name}.master.codedir" => {
      'setting' => 'codedir',
      'value'   => $puppet_codedir,
    },
  }

  $master_settings = merge(
    $default_settings,
    $custom_settings,
  )

  create_resources(::ospuppet::config::main_config::master, $master_settings)

}
