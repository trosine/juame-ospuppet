# PRIVATE CLASS - do not use directly
class ospuppet::agent::service {

  $service_name    = $::ospuppet::agent::service_name
  $service_running = $::ospuppet::agent::service_running
  $service_enabled = $::ospuppet::agent::service_enabled

  service { $service_name:
    ensure => $service_running,
    enable => $service_enabled,
  }

}
