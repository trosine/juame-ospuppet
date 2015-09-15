# PRIVATE CLASS - do not use directly
class ospuppet::agent::service {

  $agent_service_name    = $::ospuppet::agent_service_name
  $agent_service_running = $::ospuppet::agent_service_running
  $agent_service_enabled = $::ospuppet::agent_service_enabled

  service { $agent_service_name:
    ensure => $agent_service_running,
    enable => $agent_service_enabled,
  }

}
