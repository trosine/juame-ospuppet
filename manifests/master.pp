# Class to configure a Puppet Master. See README.md for more details.
class ospuppet::master (
  $hiera_config                = $::ospuppet::master::params::hiera_config,
  $hiera_backends              = $::ospuppet::master::params::hiera_backends,
  $hiera_hierarchy             = $::ospuppet::master::params::hiera_hierarchy,
  $hiera_yaml_datadir          = $::ospuppet::master::params::hiera_yaml_datadir,
  $hiera_merge_package_name    = $::ospuppet::master::params::hiera_merge_package_name,
  $hiera_merge_package_version = $::ospuppet::master::params::hiera_merge_package_version,
  $hiera_merge_behavior        = $::ospuppet::master::params::hiera_merge_behavior,
  $hiera_logger                = $::ospuppet::master::params::hiera_logger,
  $hiera_eyaml_package_name    = $::ospuppet::master::params::hiera_eyaml_package_name,
  $hiera_eyaml_package_version = $::ospuppet::master::params::hiera_eyaml_package_version,
  $hiera_eyaml_extension       = $::ospuppet::master::params::hiera_eyaml_extension,
  $hiera_eyaml_key_dir         = $::ospuppet::master::params::hiera_eyaml_key_dir,
  $hiera_eyaml_private_key     = $::ospuppet::master::params::hiera_eyaml_private_key,
  $hiera_eyaml_public_key      = $::ospuppet::master::params::hiera_eyaml_public_key,
) inherits ::ospuppet::master::params {

  require ospuppet

  if defined(Class[::ospuppet::server]) {
    $notify_server = true
  }

  validate_absolute_path(
    $hiera_config,
    $hiera_yaml_datadir,
    $hiera_eyaml_key_dir,
  )

  validate_array(
    $hiera_backends,
    $hiera_hierarchy,
  )

  validate_string(
    $hiera_merge_package_name,
    $hiera_merge_package_version,
    $hiera_merge_behavior,
    $hiera_logger,
    $hiera_eyaml_package_name,
    $hiera_eyaml_package_version,
    $hiera_eyaml_extension,
    $hiera_eyaml_private_key,
    $hiera_eyaml_public_key,
  )

  validate_re($hiera_merge_behavior, '^(native|deep|deeper)$')
  validate_re($hiera_logger, '^(noop|puppet|console)$')

  contain ospuppet::master::config

}
