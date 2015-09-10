# PRIVATE CLASS - do not use directly
class ospuppet::master::config::hiera {

  $puppet_user                 = $::ospuppet::master::puppet_user
  $puppet_group                = $::ospuppet::master::puppet_group
  $hiera_config                = $::ospuppet::master::hiera_config
  $hiera_backends              = $::ospuppet::master::hiera_backends
  $hiera_hierarchy             = $::ospuppet::master::hiera_hierarchy
  $hiera_yaml_datadir          = $::ospuppet::master::hiera_yaml_datadir
  $hiera_merge_behavior        = $::ospuppet::master::hiera_merge_behavior
  $hiera_logger                = $::ospuppet::master::hiera_logger
  $hiera_eyaml_extension       = $::ospuppet::master::hiera_eyaml_extension
  $hiera_eyaml_key_dir         = $::ospuppet::master::hiera_eyaml_key_dir
  $hiera_eyaml_private_key     = $::ospuppet::master::hiera_eyaml_private_key
  $hiera_eyaml_public_key      = $::ospuppet::master::hiera_eyaml_public_key

  if member($hiera_backends, 'yaml') {
    $yaml_enabled = true
  } else {
    $yaml_enabled = false
  }

  if member($hiera_backends, 'eyaml') {
    $eyaml_enabled = true
    contain ::ospuppet::master::config::hiera::eyaml
  } else {
    $eyaml_enabled = false
  }

  if $hiera_merge_behavior =~ /^(deep|deeper)$/ {
    contain ::ospuppet::master::config::hiera::merge
  }

  file { $hiera_config:
    ensure  => file,
    owner   => $puppet_user,
    group   => $puppet_group,
    mode    => '0644',
    content => template("${module_name}/master/hiera.yaml.erb"),
  }

}
