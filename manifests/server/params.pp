# PRIVATE CLASS - do not use directly
class ospuppet::server::params {

  case $::osfamily {
    'Debian': {
      $init_settings_config = '/etc/default/puppetserver'
    }
    'RedHat': {
      $init_settings_config = '/etc/sysconfig/puppetserver'
    }
    default: {
      fail("osfamily ${::osfamily} not supported")
    }
  }

}
