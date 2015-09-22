require 'spec_helper'
describe 'ospuppet::master::config::settings' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::master": }'
  end

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::master::config::settings') }
  end

  context 'validation of default configuration parameters' do
    context 'should contain ini_setting resources with default params' do
      it { should contain_ini_setting('ospuppet::master::config::settings.vardir')
        .with_ensure('present')
        .with_section('master')
        .with_setting('vardir')
        .with_value('/opt/puppetlabs/server/data/puppetserver')
      }
      it { should contain_ini_setting('ospuppet::master::config::settings.logdir')
        .with_ensure('present')
        .with_section('master')
        .with_setting('logdir')
        .with_value('/var/log/puppetlabs/puppetserver')
      }
      it { should contain_ini_setting('ospuppet::master::config::settings.rundir')
        .with_ensure('present')
        .with_section('master')
        .with_setting('rundir')
        .with_value('/var/run/puppetlabs/puppetserver')
      }
      it { should contain_ini_setting('ospuppet::master::config::settings.pidfile')
        .with_ensure('present')
        .with_section('master')
        .with_setting('pidfile')
        .with_value('/var/run/puppetlabs/puppetserver/puppetserver.pid')
      }
      it { should contain_ini_setting('ospuppet::master::config::settings.codedir')
        .with_ensure('present')
        .with_section('master')
        .with_setting('codedir')
        .with_value('/etc/puppetlabs/code')
      }
    end
    context 'use custom_settings to define ini setting' do
      let(:pre_condition) {
        'class { "ospuppet::master":
          custom_settings => {
            "environmentpath" => {
              "setting"    => "environmentpath",
              "value"      => "/tmp/puppet/environments",
            },
          },
        }'
      }
      it { should contain_ini_setting('environmentpath')
        .with_ensure('present')
        .with_section('master')
        .with_setting('environmentpath')
        .with_value('/tmp/puppet/environments')
      }
    end
  end

end