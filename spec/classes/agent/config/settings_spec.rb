require 'spec_helper'
describe 'ospuppet::agent::config::settings' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:node) { 'testhost.example.com' }

  let(:pre_condition) do
    'class { "ospuppet": }'
  end

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::agent::config::settings') }
  end

  context 'validation of default configuration parameters' do
    context 'should contain ini_setting resources with default params' do
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_certname')\
        .with_setting('certname')
        .with_value('testhost.example.com')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_server')\
        .with_setting('server')
        .with_value('puppet')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_server')\
        .with_setting('server')
        .with_value('puppet')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_ca_server')\
        .with_setting('ca_server')
        .with_ensure('absent')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_report')\
        .with_setting('report')
        .with_value(true)
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_report_server')\
        .with_setting('report_server')
        .with_ensure('absent')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_environment')\
        .with_setting('environment')
        .with_value('production')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_priority')\
        .with_setting('priority')
        .with_ensure('absent')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_usecacheonfailure')\
        .with_setting('usecacheonfailure')
        .with_value(true)
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_runinterval')\
        .with_setting('runinterval')
        .with_value('30m')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_waitforcert')\
        .with_setting('waitforcert')
        .with_value('2m')
      }
      it { should contain_ini_setting('ospuppet::agent::config::settings.agent_daemonize')\
        .with_setting('daemonize')
        .with_value(true)
      }
    end
  end

end
