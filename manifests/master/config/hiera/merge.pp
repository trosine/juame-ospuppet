# PRIVATE CLASS - do not use directly
class ospuppet::master::config::hiera::merge {

  $puppet_gem_provider          = $::ospuppet::puppet_gem_provider
  $puppetserver_gem_provider    = $::ospuppet::puppetserver_gem_provider
  $gem_provider_install_options = $::ospuppet::master::gem_provider_install_options
  $hiera_merge_package_name     = $::ospuppet::master::hiera_merge_package_name
  $hiera_merge_package_version  = $::ospuppet::master::hiera_merge_package_version

  package { "puppet.${hiera_merge_package_name}":
    ensure          => $hiera_merge_package_version,
    name            => $hiera_merge_package_name,
    install_options => $gem_provider_install_options,
    provider        => $puppet_gem_provider,
  }

  if (defined(Class['ospuppet::server'])) {
    # it is only necessary to install the puppetserver gem with puppetserver

    if (versioncmp($::serverversion,'4.0.0') >= 0) {

      # the puppetserver_gem provider only works with puppet >= 4.0
      package { "puppetserver.${hiera_merge_package_name}":
        ensure          => $hiera_merge_package_version,
        name            => $hiera_merge_package_name,
        install_options => $gem_provider_install_options,
        provider        => $puppetserver_gem_provider,
      }

    }
    elsif ($hiera_merge_package_version != 'absent') {

      if ($hiera_merge_package_version == 'latest') {
        warning("ospuppet::master: For Puppet < 4.0, ensuring hiera-merge to 'latest' is equivalent to 'installed'")
      }
      case $hiera_merge_package_version {
        /^(present|installed)$/: { $install_version = "" }
        /^latest$/:              { $install_version = "" }
        default:                 { $install_version = "--version ${hiera_merge_package_version}" }
      }

      exec { "puppetserver.${hiera_merge_package_name}":
        command => "puppetserver gem install ${hiera_merge_package_name} ${gem_provider_install_options} ${install_version}",
        onlyif  => "puppetserver gem specification --local ${hiera_merge_package_name} name 2>&1 | grep ^ERROR:",
        require => Class['ospuppet::server::config']
      }

    }
  }
}
