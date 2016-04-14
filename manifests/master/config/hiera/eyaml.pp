# PRIVATE CLASS - do not use directly
class ospuppet::master::config::hiera::eyaml {

  $puppet_user                  = $::ospuppet::puppet_user
  $puppet_group                 = $::ospuppet::puppet_group
  $puppet_gem_provider          = $::ospuppet::puppet_gem_provider
  $puppetserver_gem_provider    = $::ospuppet::puppetserver_gem_provider
  $gem_provider_install_options = $::ospuppet::master::gem_provider_install_options
  $hiera_eyaml_package_name     = $::ospuppet::master::hiera_eyaml_package_name
  $hiera_eyaml_package_version  = $::ospuppet::master::hiera_eyaml_package_version
  $hiera_eyaml_key_dir          = $::ospuppet::master::hiera_eyaml_key_dir
  $hiera_eyaml_private_key      = $::ospuppet::master::hiera_eyaml_private_key
  $hiera_eyaml_public_key       = $::ospuppet::master::hiera_eyaml_public_key

  package { "puppet.${hiera_eyaml_package_name}":
    ensure          => $hiera_eyaml_package_version,
    name            => $hiera_eyaml_package_name,
    install_options => $gem_provider_install_options,
    provider        => $puppet_gem_provider,
  }

  if (defined(Class['ospuppet::server'])) {
    # it is only necessary to install the puppetserver gem with puppetserver

    if (versioncmp($::serverversion,'4.0.0') >= 0) {

      # the puppetserver_gem provider only works with puppet >= 4.0
      package { "puppetserver.${hiera_eyaml_package_name}":
        ensure          => $hiera_eyaml_package_version,
        name            => $hiera_eyaml_package_name,
        install_options => $gem_provider_install_options,
        provider        => $puppetserver_gem_provider,
      }

    }
    elsif ($hiera_eyaml_package_version != 'absent') {

      if ($hiera_eyaml_package_version == 'latest') {
        warning("ospuppet::master: For Puppet < 4.0, ensuring hiera-eyaml to 'latest' is equivalent to 'installed'")
      }
      case $hiera_eyaml_package_version {
        /^(present|installed)$/: { $install_version = "" }
        /^latest$/:              { $install_version = "" }
        default:                 { $install_version = "--version ${hiera_eyaml_package_version}" }
      }

      exec { "puppetserver.${hiera_eyaml_package_name}":
        command => "puppetserver gem install --no-ri --no-rdoc --env-shebang ${hiera_eyaml_package_name} ${gem_provider_install_options} ${install_version}",
        creates => "${ospuppet::server::puppetserver_gem_home}/bin/eyaml",
        require => Class['ospuppet::server::config']
      }

    }
  }

  file { $hiera_eyaml_key_dir:
    ensure => directory,
    owner  => $puppet_user,
    group  => $puppet_group,
    mode   => '0771',
    before => Exec["${module_name}.${name}.createkeys"],
  }

  $_createkeys_private="--pkcs7-private-key=${hiera_eyaml_key_dir}/${hiera_eyaml_private_key}"
  $_createkeys_public="--pkcs7-public-key=${hiera_eyaml_key_dir}/${hiera_eyaml_public_key}"
  exec { "${module_name}.${name}.createkeys":
    path      => '/opt/puppetlabs/puppet/bin',
    command   => "eyaml createkeys ${_createkeys_private} ${_createkeys_public}",
    user      => $puppet_user,
    creates   => "${hiera_eyaml_key_dir}/${hiera_eyaml_private_key}",
    logoutput => true,
    require   => Package["puppet.${hiera_eyaml_package_name}"],
  }

}
