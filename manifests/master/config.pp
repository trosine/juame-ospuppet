# PRIVATE CLASS - do not use directly
class ospuppet::master::config {

  $notify_server = $::ospuppet::master::notify_server

  if $notify_server {
    Class[ospuppet::master::config::hiera] ~> Class[ospuppet::server::service]
  }

  contain ospuppet::master::config::hiera

}
