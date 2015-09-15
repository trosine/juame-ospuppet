# PRIVATE CLASS - do not use directly
class ospuppet::agent::install {
  $package_name                = $::ospuppet::package_name
  $package_version             = $::ospuppet::package_version

  package { $package_name:
    ensure => $package_version,
  }

}
