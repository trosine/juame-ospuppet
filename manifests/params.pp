# PRIVATE CLASS - do not use directly
class ospuppet::params {

  $puppet_user             = 'puppet'
  $puppet_group            = 'puppet'
  $puppet_confdir          = '/etc/puppetlabs/puppet'
  $puppet_config           = 'puppet.conf'
  $puppet_gem_provider     = 'puppet_gem'
  $package_name            = 'puppet-agent'
  $package_version         = 'latest'
  $agent_service_name      = 'puppet'
  $agent_service_running   = false
  $agent_service_enabled   = true
  $agent_certname          = $::fqdn
  $agent_server            = 'puppet'
  $agent_ca_server         = undef
  $agent_report            = true
  $agent_report_server     = undef
  $agent_environment       = production
  $agent_priority          = undef
  $agent_usecacheonfailure = true
  $agent_runinterval       = '30m'
  $agent_waitforcert       = '2m'
  $agent_daemonize         = true
  $agent_custom_settings   = {}

  case $::osfamily {
    'Debian': {
      $agent_init_settings_config = '/etc/default/puppet'
    }
    'RedHat': {
      $agent_init_settings_config = '/etc/sysconfig/puppet'
    }
    default: {
      fail("osfamily ${::osfamily} not supported")
    }
  }

}
