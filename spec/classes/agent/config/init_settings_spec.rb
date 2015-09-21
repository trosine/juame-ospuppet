require 'spec_helper'
describe 'ospuppet::agent::config::init_settings' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::agent": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::agent::config::init_settings') }
  end

  context 'ini_setting and two ini_subsettings' do
    context 'should contain two ini_settings' do
      let(:pre_condition) {
        'class { "ospuppet::agent":
          init_settings_custom_settings    => {
            "foo" => {
              "setting" => "foo",
              "value"   => "bar",
            },
            "example" => {
              "ensure"  => "absent",
              "setting" => "example",
            },
          },
        }'
      }
      it { should contain_ini_setting('foo')
        .with_ensure('present')
        .with_path('/etc/sysconfig/puppet')
        .with_section('')
        .with_setting('foo')
        .with_value('bar')
      }
      it { should contain_ini_setting('example')
        .with_ensure('absent')
        .with_path('/etc/sysconfig/puppet')
        .with_section('')
        .with_setting('example')
      }
    end
    context 'should contain two ini_subsetting' do
      let(:pre_condition) {
        'class { "ospuppet::agent":
          init_settings_custom_subsettings => {
            "waitforcert" => {
              "setting"    => "PUPPET_EXTRA_OPTS",
              "subsetting" => "--waitforcert=",
              "value"      => "500",
            },
            "test" => {
              "ensure"     => "absent",
              "setting"    => "PUPPET_EXTRA_OPTS",
              "subsetting" => "--test=",
            },
          },
        }'
      }
      it { should contain_ini_subsetting('waitforcert')
        .with_ensure('present')
        .with_path('/etc/sysconfig/puppet')
        .with_section('')
        .with_setting('PUPPET_EXTRA_OPTS')
        .with_subsetting('--waitforcert=')
        .with_value('500') }
      it { should contain_ini_subsetting('test')
        .with_ensure('absent')
        .with_path('/etc/sysconfig/puppet')
        .with_section('')
        .with_setting('PUPPET_EXTRA_OPTS')
        .with_subsetting('--test=') }
    end
  end

end
