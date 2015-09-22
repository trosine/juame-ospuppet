# PRIVATE CLASS - do not use directly
class ospuppet::master::config {

  contain ospuppet::master::config::hiera
  contain ospuppet::master::config::settings

}
