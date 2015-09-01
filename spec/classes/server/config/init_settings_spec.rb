require 'spec_helper'
describe 'ospuppet::server::config::init_settings' do

  let (:facts) { { :operatingsystem => 'CentOS' } }

  let(:pre_condition) do
    'class { "ospuppet::server": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server::config::init_settings') }
  end

  describe 'init settings default config - resource ini_setting validation with default parameters' do
    context 'should contain ini_setting resource for JAVA_BIN with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-JAVA_BIN')\
        .with_setting('JAVA_BIN').with_value('"/usr/bin/java"') }
    end
    context 'should contain ini_setting resource for USER with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-USER')\
        .with_setting('USER').with_value('"puppet"') }
    end
    context 'should contain ini_setting resource for GROUP with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-GROUP')\
        .with_setting('GROUP').with_value('"puppet"') }
    end
    context 'should contain ini_setting resource for INSTALL_DIR with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-INSTALL_DIR')\
        .with_setting('INSTALL_DIR').with_value('"/opt/puppetlabs/server/apps/puppetserver"') }
    end
    context 'should contain ini_setting resource for CONFIG with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-CONFIG')\
        .with_setting('CONFIG').with_value('"/etc/puppetlabs/puppetserver/conf.d"') }
    end
    context 'should contain ini_setting resource for BOOTSTRAP_CONFIG with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-BOOTSTRAP_CONFIG')\
        .with_setting('BOOTSTRAP_CONFIG').with_value('"/etc/puppetlabs/puppetserver/bootstrap.cfg"') }
    end
    context 'should contain ini_setting resource for SERVICE_STOP_RETRIES with default value' do
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-SERVICE_STOP_RETRIES')\
        .with_setting('SERVICE_STOP_RETRIES').with_value('60') }
    end
  end

  describe 'init settings default config - resource ini_setting validation with specified parameters' do
    context 'should contain ini_setting resource for JAVA_BIN with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_java_bin => "/tmp/java" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-JAVA_BIN')\
        .with_setting('JAVA_BIN').with_value('"/tmp/java"') }
    end
    context 'should contain ini_setting resource for USER with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_user => "foobar" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-USER')\
        .with_setting('USER').with_value('"foobar"') }
    end
    context 'should contain ini_setting resource for GROUP with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_group => "foobar" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-GROUP')\
        .with_setting('GROUP').with_value('"foobar"') }
    end
    context 'should contain ini_setting resource for INSTALL_DIR with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_install_dir => "/tmp/puppetserver" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-INSTALL_DIR')\
        .with_setting('INSTALL_DIR').with_value('"/tmp/puppetserver"') }
    end
    context 'should contain ini_setting resource for CONFIG with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": config_dir => "/tmp/puppetserver/initsettings" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-CONFIG')\
        .with_setting('CONFIG').with_value('"/tmp/puppetserver/initsettings"') }
    end
    context 'should contain ini_setting resource for BOOTSTRAP_CONFIG with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_bootstrap_config => "/tmp/puppetserver/boot" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-BOOTSTRAP_CONFIG')\
        .with_setting('BOOTSTRAP_CONFIG').with_value('"/tmp/puppetserver/boot"') }
    end
    context 'should contain ini_setting resource for SERVICE_STOP_RETRIES with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_service_stop_retries => "32" }'
      end
      it { should contain_ini_setting('ospuppet-puppetserver-init-setting-SERVICE_STOP_RETRIES')\
        .with_setting('SERVICE_STOP_RETRIES').with_value('32') }
    end
  end

  describe 'init settings default config - resource ini_subsetting validation with default parameters' do
    context 'should contain ini_subsetting resource for Xms with default value' do
      it { should contain_ini_subsetting('ospuppet-puppetserver-init-setting-JAVA_ARGS-Xms')\
        .with_setting('JAVA_ARGS').with_subsetting('-Xms').with_value('512m') }
    end
    context 'should contain ini_subsetting resource for Xmx with default value' do
      it { should contain_ini_subsetting('ospuppet-puppetserver-init-setting-JAVA_ARGS-Xmx')\
        .with_setting('JAVA_ARGS').with_subsetting('-Xmx').with_value('512m') }
    end
    context 'should contain ini_subsetting resource for XX:MaxPermSize with default value' do
      it { should contain_ini_subsetting('ospuppet-puppetserver-init-setting-JAVA_ARGS-XX:MaxPermSize')\
        .with_setting('JAVA_ARGS').with_subsetting('-XX:MaxPermSize=').with_value('256m') }
    end
  end

  describe 'init settings default config - resource ini_subsetting validation with specified parameters' do
    context 'should contain ini_subsetting resource for Xms with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_java_xms => "128m" }'
      end
      it { should contain_ini_subsetting('ospuppet-puppetserver-init-setting-JAVA_ARGS-Xms')\
        .with_setting('JAVA_ARGS').with_subsetting('-Xms').with_value('128m').with_quote_char('"') }
    end
    context 'should contain ini_subsetting resource for Xmx with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_java_xmx => "128m" }'
      end
      it { should contain_ini_subsetting('ospuppet-puppetserver-init-setting-JAVA_ARGS-Xmx')\
        .with_setting('JAVA_ARGS').with_subsetting('-Xmx').with_value('128m').with_quote_char('"') }
    end
    context 'should contain ini_subsetting resource for XX:MaxPermSize with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": init_settings_java_maxpermsize => "128m" }'
      end
      it { should contain_ini_subsetting('ospuppet-puppetserver-init-setting-JAVA_ARGS-XX:MaxPermSize')\
        .with_setting('JAVA_ARGS').with_subsetting('-XX:MaxPermSize=').with_value('128m').with_quote_char('"') }
    end
  end

  describe 'init settings custom settings' do
    context 'it should have no settings when init_settings_custom_settings is default (empty hash)' do
      it { should have_ini_setting_resource_count(7) }
    end
    context 'init_settings_custom_settings used for parameter foo' do
      let(:pre_condition) do
        'class {
          "ospuppet::server": init_settings_custom_settings => {
            "foo" => {
              "ensure"  => "present",
              "section" => "",
              "setting"   => "foo",
              "value"    => "bar",
            },
          },
        }'
      end
      it { should contain_ini_setting('foo')
        .with_section('')
        .with_setting('foo')
        .with_value('bar') }
    end
    context 'it should have no settings when $init_settings_custom_subsettings is default (empty hash)' do
      it { should have_ini_subsetting_resource_count(3) }
    end
    context '$init_settings_custom_subsettings used for argument foobar' do
      let(:pre_condition) do
        'class {
          "ospuppet::server": init_settings_custom_subsettings => {
            "foo" => {
              "ensure"            => "present",
              "section"           => "",
              "key_val_separator" => "=",
              "setting"           => "foo",
              "subsetting"        => "foobar",
              "value"             => "bar",
            },
          },
        }'
      end
      it { should contain_ini_subsetting('foo')
        .with_section('')
        .with_setting('foo')
        .with_subsetting('foobar')
        .with_value('bar') }
    end
  end
end
