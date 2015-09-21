# PRIVATE CLASS - do not use directly
class ospuppet::agent::config {

  contain ospuppet::agent::config::init_settings
  contain ospuppet::agent::config::settings

}
