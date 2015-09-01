# PRIVATE CLASS - do not use directly
class ospuppet::server::install {

  $package_name     = $::ospuppet::server::package_name
  $ensure_installed = $::ospuppet::server::ensure_installed
  $package_version  = $::ospuppet::server::package_version

  if $ensure_installed {
    $_package_version = $package_version
  } else {
    $_package_version = absent
  }

  package { $package_name:
    ensure => $_package_version,
  }

}
