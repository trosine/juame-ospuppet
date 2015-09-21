class { '::ospuppet::agent':
  init_settings_custom_subsettings => {
    'waitforcert' => {
      'setting'    => 'PUPPET_EXTRA_OPTS',
      'subsetting' => '--waitforcert=',
      'value'      => '500',
    },
  }
}
