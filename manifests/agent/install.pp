# PRIVATE CLASS - do not use directly
class ospuppet::agent::install {
  $package_name                = $::ospuppet::agent::package_name
  $package_version             = $::ospuppet::agent::package_version

  package { $package_name:
    ensure => $package_version,
  }

}
