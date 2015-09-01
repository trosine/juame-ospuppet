class { '::ospuppet::server':
  webserver_ssl_port               => '8141',
  init_settings_custom_subsettings => {
    'java.security.properties' => {
      'ensure'            => 'absent',
      'section'           => '',
      'key_val_separator' => '=',
      'setting'           => 'JAVA_ARGS',
      'subsetting'        => '-Djava.security.properties=',
      'value'             => '/etc/sysconfig/puppetserver-properties/java.security',
    },
  },
  puppetserver_custom_settings     => {
    'max-requests-per-instance' => {
      'ensure'  => 'present',
      'setting' => 'jruby-puppet.max-requests-per-instance',
      'value'   => '0',
      'type'    => 'number',
    },
    'authorization-required'    => {
      'ensure'  => 'present',
      'setting' => 'puppet-admin.authorization-required',
      'value'   => true,
      'type'    => 'boolean',
    },
  },
  webserver_custom_settings        => {
    'shutdown-timeout-seconds' => {
      'ensure'  => 'present',
      'setting' => 'webserver.shutdown-timeout-seconds',
      'value'   => '30',
      'type'    => 'number',
    }
  }
}
