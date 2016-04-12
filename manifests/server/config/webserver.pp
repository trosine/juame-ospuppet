# PRIVATE CLASS - do not use directly
class ospuppet::server::config::webserver {

  $config_dir                  = $::ospuppet::server::config_dir
  $webserver_access_log_config = $::ospuppet::server::webserver_access_log_config
  $webserver_client_auth       = $::ospuppet::server::webserver_client_auth
  $webserver_ssl_host          = $::ospuppet::server::webserver_ssl_host
  $webserver_ssl_port          = $::ospuppet::server::webserver_ssl_port
  $webserver_custom_settings   = $::ospuppet::server::webserver_custom_settings

  $_webserver_access_log_config = {
    "${module_name}-puppetserver-webserver-access-log-config" => {
      'setting' => 'webserver.access-log-config',
      'value'   => $webserver_access_log_config,
      'type'    => 'string',
    }
  }

  $_webserver_client_auth = {
    "${module_name}-puppetserver-webserver-client-auth" => {
      'setting' => 'webserver.client-auth',
      'value'   => $webserver_client_auth,
      'type'    => 'string',
    }
  }

  $_webserver_ssl_host = {
    "${module_name}-puppetserver-webserver-ssl-host" => {
      'setting' => 'webserver.ssl-host',
      'value'   => $webserver_ssl_host,
      'type'    => 'string',
    }
  }

  $_webserver_ssl_port = {
    "${module_name}-puppetserver-webserver-ssl-port" => {
      'setting' => 'webserver.ssl-port',
      'value'   => $webserver_ssl_port,
      'type'    => 'number',
    }
  }

  $webserver_default_settings = merge(
    $_webserver_access_log_config,
    $_webserver_client_auth,
    $_webserver_ssl_host,
    $_webserver_ssl_port
  )

  $defaults = {
    'ensure' => 'present',
    'path'   => "${config_dir}/webserver.conf",
  }

  $webserver_hocon_settings = merge(
    $webserver_default_settings,
    $webserver_custom_settings
  )

  create_resources(hocon_setting, $webserver_hocon_settings, $defaults)

}
