# PRIVATE CLASS - do not use directly
class ospuppet::params {

  $puppet_user             = 'puppet'
  $puppet_group            = 'puppet'
  $puppet_confdir          = '/etc/puppetlabs/puppet'
  $puppet_config           = 'puppet.conf'
  $puppet_codedir          = '/etc/puppetlabs/code'
  $puppet_gem_provider     = 'puppet_gem'
  $puppetserver_gem_provider   = 'puppetserver_gem'

}
