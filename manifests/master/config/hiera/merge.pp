# PRIVATE CLASS - do not use directly
class ospuppet::master::config::hiera::merge {

  $puppet_gem_provider         = $::ospuppet::master::puppet_gem_provider
  $puppetserver_gem_provider   = $::ospuppet::master::puppetserver_gem_provider
  $hiera_merge_package_name    = $::ospuppet::master::hiera_merge_package_name
  $hiera_merge_package_version = $::ospuppet::master::hiera_merge_package_version

  package { "puppet.${hiera_merge_package_name}":
    ensure   => $hiera_merge_package_version,
    name     => $hiera_merge_package_name,
    provider => $puppet_gem_provider,
  }

  package { "puppetserver.${hiera_merge_package_name}":
    ensure   => $hiera_merge_package_version,
    name     => $hiera_merge_package_name,
    provider => $puppetserver_gem_provider,
  }

}
