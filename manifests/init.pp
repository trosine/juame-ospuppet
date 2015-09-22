# Class to configure the open source Puppet components. See README.md for more details.
class ospuppet (
  $puppet_user                 = $::ospuppet::params::puppet_user,
  $puppet_group                = $::ospuppet::params::puppet_group,
  $puppet_confdir              = $::ospuppet::params::puppet_confdir,
  $puppet_config               = $::ospuppet::params::puppet_config,
  $puppet_codedir              = $::ospuppet::params::puppet_codedir,
  $puppet_gem_provider         = $::ospuppet::params::puppet_gem_provider,
  $puppetserver_gem_provider   = $::ospuppet::params::puppetserver_gem_provider,
) inherits ::ospuppet::params {

  validate_string(
    $puppet_user,
    $puppet_group,
    $puppet_config,
    $puppet_gem_provider,
    $puppetserver_gem_provider,
  )

  validate_absolute_path(
    $puppet_confdir,
    $puppet_codedir,
  )

  if $caller_module_name != $module_name {
    fail("Do not use private class ${name} from outside of ${module_name}.")
  }

}
