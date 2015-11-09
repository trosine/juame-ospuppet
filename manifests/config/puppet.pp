class ospuppet::config::puppet {

  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure => file,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0644',
  }

}
