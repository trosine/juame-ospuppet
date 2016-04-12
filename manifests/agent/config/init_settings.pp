# PRIVATE CLASS - do not use directly
class ospuppet::agent::config::init_settings {

  $init_settings_config             = $::ospuppet::agent::init_settings_config
  $init_settings_custom_settings    = $::ospuppet::agent::init_settings_custom_settings
  $init_settings_custom_subsettings = $::ospuppet::agent::init_settings_custom_subsettings

  $defaults = {
    'ensure'            => 'present',
    'path'              => $init_settings_config,
    'section'           => '',
    'key_val_separator' => '=',
  }

  $initsettings_ini_settings = merge(
    $init_settings_custom_settings,
    {}
  )

  $initsettings_ini_subsettings = merge(
    $init_settings_custom_subsettings,
    {}
  )

  create_resources(ini_setting, $initsettings_ini_settings, $defaults)
  create_resources(ini_subsetting, $initsettings_ini_subsettings, $defaults)

}
