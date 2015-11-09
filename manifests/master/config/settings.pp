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
    "${name}.vardir" => {
      'setting' => 'vardir',
      'value'   => $vardir,
    },
    "${name}.logdir" => {
      'setting' => 'logdir',
      'value'   => $logdir,
    },
    "${name}.rundir" => {
      'setting' => 'rundir',
      'value'   => $rundir,
    },
    "${name}.pidfile" => {
      'setting' => 'pidfile',
      'value'   => $pidfile,
    },
    "${name}.codedir" => {
      'setting' => 'codedir',
      'value'   => $puppet_codedir,
    },
  }

  $settings = merge(
    $default_settings,
    $custom_settings,
  )

  create_resources(::ospuppet::config::main_config::master, $settings)

}
