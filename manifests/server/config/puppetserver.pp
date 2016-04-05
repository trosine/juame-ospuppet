# PRIVATE CLASS - do not use directly
class ospuppet::server::config::puppetserver {

  $config_dir                          = $::ospuppet::server::config_dir
  $puppetserver_ruby_load_path         = $::ospuppet::server::puppetserver_ruby_load_path
  $puppetserver_gem_home               = $::ospuppet::server::puppetserver_gem_home
  $puppetserver_master_conf_dir        = $::ospuppet::server::puppetserver_master_conf_dir
  $puppetserver_master_code_dir        = $::ospuppet::server::puppetserver_master_code_dir
  $puppetserver_master_var_dir         = $::ospuppet::server::puppetserver_master_var_dir
  $puppetserver_master_run_dir         = $::ospuppet::server::puppetserver_master_run_dir
  $puppetserver_master_log_dir         = $::ospuppet::server::puppetserver_master_log_dir
  $puppetserver_max_active_instances   = $::ospuppet::server::puppetserver_max_active_instances
  $puppetserver_profiler_enabled       = $::ospuppet::server::puppetserver_profiler_enabled
  $puppetserver_custom_settings        = $::ospuppet::server::puppetserver_custom_settings

  $_puppetserver_ruby_load_path = {
    "${module_name}-puppetserver-ruby-load-path" => {
      'setting' => 'jruby-puppet.ruby-load-path',
      'value'   => $puppetserver_ruby_load_path,
      'type'    => 'array',
    }
  }

  $_puppetserver_gem_home = {
    "${module_name}-puppetserver-gem-home" => {
      'setting' => 'jruby-puppet.gem-home',
      'value'   => $puppetserver_gem_home,
      'type'    => 'string',
    }
  }

  $_puppetserver_master_conf_dir = {
    "${module_name}-puppetserver-master-conf-dir" => {
      'setting' => 'jruby-puppet.master-conf-dir',
      'value'   => $puppetserver_master_conf_dir,
      'type'    => 'string',
    }
  }

  $_puppetserver_master_code_dir = {
    "${module_name}-puppetserver-master-code-dir" => {
      'setting' => 'jruby-puppet.master-code-dir',
      'value'   => $puppetserver_master_code_dir,
      'type'    => 'string',
    }
  }

  $_puppetserver_master_var_dir = {
    "${module_name}-puppetserver-master-var-dir" => {
      'setting' => 'jruby-puppet.master-var-dir',
      'value'   => $puppetserver_master_var_dir,
      'type'    => 'string',
    }
  }

  $_puppetserver_master_run_dir = {
    "${module_name}-puppetserver-master-run-dir" => {
      'setting' => 'jruby-puppet.master-run-dir',
      'value'   => $puppetserver_master_run_dir,
      'type'    => 'string',
    }
  }

  $_puppetserver_master_log_dir = {
    "${module_name}-puppetserver-master-log-dir" => {
      'setting' => 'jruby-puppet.master-log-dir',
      'value'   => $puppetserver_master_log_dir,
      'type'    => 'string',
    }
  }

  if $puppetserver_max_active_instances {
    $_puppetserver_max_active_instances = {
      "${module_name}-puppetserver-max-active-instances" => {
        'setting' => 'jruby-puppet.max-active-instances',
        'value'   => $puppetserver_max_active_instances,
        'type'    => 'number',
      }
    }
  } else {
    $_puppetserver_max_active_instances = {}
  }

  $_puppetserver_profiler_enabled = {
    "${module_name}-puppetserver-profiler-enabled" => {
      'setting' => 'profiler.enabled',
      'value'   => $puppetserver_profiler_enabled,
      'type'    => 'boolean',
    }
  }

  $puppetserver_default_settings = merge(
    $_puppetserver_ruby_load_path,
    $_puppetserver_gem_home,
    $_puppetserver_master_conf_dir,
    $_puppetserver_master_code_dir,
    $_puppetserver_master_var_dir,
    $_puppetserver_master_run_dir,
    $_puppetserver_master_log_dir,
    $_puppetserver_max_active_instances,
    $_puppetserver_profiler_enabled,
  )

  $defaults = {
    'ensure'  => 'present',
    'path' => "${config_dir}/puppetserver.conf",
  }

  $puppetserver_hocon_settings = merge(
    $puppetserver_default_settings,
    $puppetserver_custom_settings,
  )

  create_resources(hocon_setting, $puppetserver_hocon_settings, $defaults)

}
