# PRIVATE CLASS - do not use directly
class ospuppet::server::service {

  $service_name    = $::ospuppet::server::service_name
  $service_enabled = $::ospuppet::server::service_enabled
  $service_running = $::ospuppet::server::service_running
  $service_manage_master   = $::ospuppet::server::service_manage_master

  if $service_manage_master {
    service { 'puppetmaster':
      ensure => 'stopped',
      enable => false,
      before => Service[$service_name],
    }
  }

  service { $service_name:
    ensure => $service_running,
    enable => $service_enabled,
  }

}
