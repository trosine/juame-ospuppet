# PRIVATE CLASS - do not use directly
class ospuppet::server::config {

  contain ospuppet::server::config::init_settings
  contain ospuppet::server::config::puppetserver
  contain ospuppet::server::config::webserver

}
