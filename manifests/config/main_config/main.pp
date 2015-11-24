define ospuppet::config::main_config::main (
  $ensure  = 'present',
  $section = 'main',
  $setting = undef,
  $value   = undef,
) {

  require ospuppet

  validate_re($ensure, [ '^present$', '^absent$' ], 'Valid values for $ensure are present or absent.')

  validate_string(
    $section,
    $setting,
  )

  ini_setting { $name:
    ensure            => $ensure,
    path              => "${::ospuppet::puppet_confdir}/${::ospuppet::puppet_config}",
    section           => $section,
    setting           => $setting,
    value             => $value,
    key_val_separator => ' = ',
  }

}
