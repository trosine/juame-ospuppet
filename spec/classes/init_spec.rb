require 'spec_helper'
describe 'ospuppet' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet') }
  end

  describe 'subclasses should be included' do
    context 'should contain params class' do
      it { should contain_class('ospuppet::params') }
    end
    context 'should contain install class' do
      it { should contain_class('ospuppet::agent::install') }
    end
    context 'should contain config class' do
      it { should contain_class('ospuppet::agent::config') }
    end
    context 'should contain service class' do
      it { should contain_class('ospuppet::agent::service') }
    end
  end

  describe 'class relationship validation' do
    context 'class install should come before class config' do
      it { should contain_class('ospuppet::agent::install').that_comes_before('ospuppet::agent::config')}
    end
    context 'class config should notify class service' do
      it { should contain_class('ospuppet::agent::config').that_notifies('ospuppet::agent::service')}
    end
  end

  context 'parameter validation' do
    context '$agent_runinterval should match regex for 30s' do
      let(:params) { { :agent_runinterval => '30s' } }
      it { should compile }
    end
    context '$agent_runinterval should match regex for 30m' do
      let(:params) { { :agent_runinterval => '30m' } }
      it { should compile }
    end
    context '$agent_runinterval should match regex for 30h' do
      let(:params) { { :agent_runinterval => '30h' } }
      it { should compile }
    end
    context '$agent_runinterval should match regex for 1d' do
      let(:params) { { :agent_runinterval => '1d' } }
      it { should compile }
    end
    context '$agent_runinterval should match regex for 1y' do
      let(:params) { { :agent_runinterval => '1y' } }
      it { should compile }
    end
    context '$agent_waitforcert should match regex for 30s' do
      let(:params) { { :agent_waitforcert => '30s' } }
      it { should compile }
    end
    context '$agent_waitforcert should match regex for 30m' do
      let(:params) { { :agent_waitforcert => '30m' } }
      it { should compile }
    end
    context '$agent_waitforcert should match regex for 30h' do
      let(:params) { { :agent_waitforcert => '30h' } }
      it { should compile }
    end
    context '$agent_waitforcert should match regex for 1d' do
      let(:params) { { :agent_waitforcert => '1d' } }
      it { should compile }
    end
    context '$agent_waitforcert should match regex for 1y' do
      let(:params) { { :agent_waitforcert => '1y' } }
      it { should compile }
    end
  end

  describe 'parameter validation fails' do
    context '$puppet_user should fail because it is not string' do
      let(:params) { { :puppet_user => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$puppet_group should fail because it is not string' do
      let(:params) { { :puppet_group => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$puppet_confdir should fail because it is not absolute path' do
      let(:params) { { :puppet_confdir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppet_config should fail because it is not string' do
      let(:params) { { :puppet_config => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$puppet_gem_provider should fail because it is not string' do
      let(:params) { { :puppet_gem_provider => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$package_name should fail because it is not string' do
      let(:params) { { :package_name => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$package_version should fail because it is not string' do
      let(:params) { { :package_version => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_service_name should fail because it is not string' do
      let(:params) { { :agent_service_name => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_service_running should fail because it is not boolean' do
      let(:params) { { :agent_service_running => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$agent_service_enabled should fail because it is not boolean' do
      let(:params) { { :agent_service_enabled => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$agent_init_settings_config should fail because it is not absolute path' do
      let(:params) { { :agent_init_settings_config => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$agent_certname should fail because it is not string' do
      let(:params) { { :agent_certname => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_server should fail because it is not string' do
      let(:params) { { :agent_server => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_ca_server should fail because it is not string' do
      let(:params) { { :agent_ca_server => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_report should fail because it is not boolean' do
      let(:params) { { :agent_report => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$agent_report_server should fail because it is not string' do
      let(:params) { { :agent_report_server => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_environment should fail because it is not string' do
      let(:params) { { :agent_environment => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_priority should fail because it is not string' do
      let(:params) { { :agent_priority => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /to be an Integer, got String/)
      end
    end
    context '$agent_usecacheonfailure should fail because it is not boolean' do
      let(:params) { { :agent_usecacheonfailure => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$agent_runinterval should fail because it is not string' do
      let(:params) { { :agent_runinterval => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_runinterval should fail because it is not ending with correct extension' do
      let(:params) { { :agent_runinterval => '30weeks' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$agent_waitforcert should fail because it is not string' do
      let(:params) { { :agent_waitforcert => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$agent_waitforcert should fail because it is not ending with correct extension' do
      let(:params) { { :agent_waitforcert => '30weeks' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$agent_daemonize should fail because it is not boolean' do
      let(:params) { { :agent_daemonize => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$agent_custom_settings should fail because it is not hash' do
      let(:params) { { :agent_custom_settings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
  end

end
