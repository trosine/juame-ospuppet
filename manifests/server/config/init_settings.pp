# PRIVATE CLASS - do not use directly
class ospuppet::server::config::init_settings {

  $config_dir                         = $::ospuppet::server::config_dir
  $init_settings_config               = $::ospuppet::server::init_settings_config
  $init_settings_java_bin             = $::ospuppet::server::init_settings_java_bin
  $init_settings_java_xms             = $::ospuppet::server::init_settings_java_xms
  $init_settings_java_xmx             = $::ospuppet::server::init_settings_java_xmx
  $init_settings_java_maxpermsize     = $::ospuppet::server::init_settings_java_maxpermsize
  $init_settings_user                 = $::ospuppet::server::init_settings_user
  $init_settings_group                = $::ospuppet::server::init_settings_group
  $init_settings_install_dir          = $::ospuppet::server::init_settings_install_dir
  $init_settings_bootstrap_config     = $::ospuppet::server::init_settings_bootstrap_config
  $init_settings_service_stop_retries = $::ospuppet::server::init_settings_service_stop_retries
  $init_settings_custom_settings      = $::ospuppet::server::init_settings_custom_settings
  $init_settings_custom_subsettings   = $::ospuppet::server::init_settings_custom_subsettings

  $_init_settings_java_bin = {
    "${module_name}-puppetserver-init-setting-JAVA_BIN" => {
      'section' => '',
      'setting' => 'JAVA_BIN',
      'value'   => "\"${init_settings_java_bin}\"",
    }
  }

  $_init_settings_java_xms = {
    "${module_name}-puppetserver-init-setting-JAVA_ARGS-Xms" => {
      'section'           => '',
      'key_val_separator' => '=',
      'quote_char'        => '"',
      'setting'           => 'JAVA_ARGS',
      'subsetting'        => '-Xms',
      'value'             => $init_settings_java_xms,
    }
  }

  $_init_settings_java_xmx = {
    "${module_name}-puppetserver-init-setting-JAVA_ARGS-Xmx" => {
      'section'           => '',
      'key_val_separator' => '=',
      'quote_char'        => '"',
      'setting'           => 'JAVA_ARGS',
      'subsetting'        => '-Xmx',
      'value'             => $init_settings_java_xmx,
    }
  }

  $_init_settings_java_maxpermsize = {
    "${module_name}-puppetserver-init-setting-JAVA_ARGS-XX:MaxPermSize" => {
      'section'           => '',
      'key_val_separator' => '=',
      'quote_char'        => '"',
      'setting'           => 'JAVA_ARGS',
      'subsetting'        => '-XX:MaxPermSize=',
      'value'             => $init_settings_java_maxpermsize,
    }
  }

  $_init_settings_user = {
    "${module_name}-puppetserver-init-setting-USER" => {
      'section' => '',
      'setting' => 'USER',
      'value'   => "\"${init_settings_user}\"",
    }
  }

  $_init_settings_group = {
    "${module_name}-puppetserver-init-setting-GROUP" => {
      'section' => '',
      'setting' => 'GROUP',
      'value'   => "\"${init_settings_group}\"",
    }
  }

  $_init_settings_install_dir = {
    "${module_name}-puppetserver-init-setting-INSTALL_DIR" => {
      'section' => '',
      'setting' => 'INSTALL_DIR',
      'value'   => "\"${init_settings_install_dir}\"",
    }
  }

  $_init_settings_config = {
    "${module_name}-puppetserver-init-setting-CONFIG" => {
      'section' => '',
      'setting' => 'CONFIG',
      'value'   => "\"${config_dir}\"",
    }
  }

  $_init_settings_bootstrap_config = {
    "${module_name}-puppetserver-init-setting-BOOTSTRAP_CONFIG" => {
      'section' => '',
      'setting' => 'BOOTSTRAP_CONFIG',
      'value'   => "\"${init_settings_bootstrap_config}\"",
    }
  }

  $_init_settings_service_stop_retries = {
    "${module_name}-puppetserver-init-setting-SERVICE_STOP_RETRIES" => {
      'section' => '',
      'setting' => 'SERVICE_STOP_RETRIES',
      'value'   => $init_settings_service_stop_retries,
    }
  }

  $init_settings_default_settings = merge(
    $_init_settings_java_bin,
    $_init_settings_user,
    $_init_settings_group,
    $_init_settings_install_dir,
    $_init_settings_config,
    $_init_settings_bootstrap_config,
    $_init_settings_service_stop_retries
  )

  $init_settings_default_subsettings = merge(
    $_init_settings_java_xms,
    $_init_settings_java_xmx,
    $_init_settings_java_maxpermsize
  )

  $defaults = {
    'ensure' => 'present',
    'path'   => $init_settings_config,
  }

  $initsettings_ini_settings = merge(
    $init_settings_default_settings,
    $init_settings_custom_settings
  )

  $initsettings_ini_subsettings = merge(
    $init_settings_default_subsettings,
    $init_settings_custom_subsettings
  )

  create_resources(ini_setting, $initsettings_ini_settings, $defaults)
  create_resources(ini_subsetting, $initsettings_ini_subsettings, $defaults)

}
