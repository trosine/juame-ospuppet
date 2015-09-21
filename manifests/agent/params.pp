# PRIVATE CLASS - do not use directly
class ospuppet::agent::params {

  $package_name      = 'puppet-agent'
  $package_version   = 'latest'
  $service_name      = 'puppet'
  $service_running   = true
  $service_enabled   = true
  $certname          = $::fqdn
  $server            = 'puppet'
  $ca_server         = undef
  $report            = true
  $report_server     = undef
  $environment       = production
  $priority          = undef
  $usecacheonfailure = true
  $runinterval       = '30m'
  $waitforcert       = '2m'
  $daemonize         = true
  $custom_settings   = {}

  case $::osfamily {
    'Debian': {
      $init_settings_config = '/etc/default/puppet'
    }
    'RedHat': {
      $init_settings_config = '/etc/sysconfig/puppet'
    }
    default: {
      fail("osfamily ${::osfamily} not supported")
    }
  }

}
