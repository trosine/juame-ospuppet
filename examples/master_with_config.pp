include ::ospuppet::server
class { '::ospuppet::master':
  hiera_merge_package_version => '1.0.1',
  hiera_eyaml_package_version => '2.0.8',
}
