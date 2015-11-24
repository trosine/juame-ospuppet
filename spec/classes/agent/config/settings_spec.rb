require 'spec_helper'
describe 'ospuppet::agent::config::settings' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:node) { 'testhost.example.com' }

  let(:pre_condition) do
    'class { "ospuppet::agent": }'
  end

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::agent::config::settings') }
  end

  context 'validation of default configuration parameters' do
    context 'should contain ini_setting resources with default params' do
      it { should contain_ini_setting('ospuppet::agent::config::settings.main.certname')\
        .with_setting('certname')
        .with_value('testhost.example.com')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.main.server')\
        .with_setting('server')
        .with_value('puppet')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.main.ca_server')\
        .with_setting('ca_server')
        .with_ensure('absent')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent.report')\
        .with_setting('report')
        .with_value(true)
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.main.report_server')\
        .with_setting('report_server')
        .with_ensure('absent')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.main.environment')\
        .with_setting('environment')
        .with_value('production')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent.priority')\
        .with_setting('priority')
        .with_ensure('absent')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent.usecacheonfailure')\
        .with_setting('usecacheonfailure')
        .with_value(true)
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent.runinterval')\
        .with_setting('runinterval')
        .with_value('30m')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent.waitforcert')\
        .with_setting('waitforcert')
        .with_value('2m')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent.daemonize')\
        .with_setting('daemonize')
        .with_value(true)
      }
    end
    context 'use custom_settings to define ini setting' do
      let(:pre_condition) {
        'class { "ospuppet::agent":
          custom_settings => {
            "foo" => {
              "setting"    => "foo",
              "value"      => "bar",
            },
          },
        }'
      }
      it { should contain_ini_setting('foo')
        .with_ensure('present')
        .with_section('agent')
        .with_setting('foo')
        .with_value('bar')
      }
    end
  end

end
