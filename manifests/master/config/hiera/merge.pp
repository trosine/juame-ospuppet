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

  package { "puppetserver.${hiera_merge_package_name}":
    ensure          => $hiera_merge_package_version,
    name            => $hiera_merge_package_name,
    install_options => $gem_provider_install_options,
    provider        => $puppetserver_gem_provider,
  }

}
