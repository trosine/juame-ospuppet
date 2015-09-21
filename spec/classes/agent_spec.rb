require 'spec_helper'
describe 'ospuppet::agent' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::agent') }
  end

  describe 'subclasses should be included' do
    context 'should contain params class' do
      it { should contain_class('ospuppet::agent::params') }
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
    context '$runinterval should match regex for 30s' do
      let(:params) { { :runinterval => '30s' } }
      it { should compile }
    end
    context '$runinterval should match regex for 30m' do
      let(:params) { { :runinterval => '30m' } }
      it { should compile }
    end
    context '$runinterval should match regex for 30h' do
      let(:params) { { :runinterval => '30h' } }
      it { should compile }
    end
    context '$runinterval should match regex for 1d' do
      let(:params) { { :runinterval => '1d' } }
      it { should compile }
    end
    context '$runinterval should match regex for 1y' do
      let(:params) { { :runinterval => '1y' } }
      it { should compile }
    end
    context '$waitforcert should match regex for 30s' do
      let(:params) { { :waitforcert => '30s' } }
      it { should compile }
    end
    context '$waitforcert should match regex for 30m' do
      let(:params) { { :waitforcert => '30m' } }
      it { should compile }
    end
    context '$waitforcert should match regex for 30h' do
      let(:params) { { :waitforcert => '30h' } }
      it { should compile }
    end
    context '$waitforcert should match regex for 1d' do
      let(:params) { { :waitforcert => '1d' } }
      it { should compile }
    end
    context '$waitforcert should match regex for 1y' do
      let(:params) { { :waitforcert => '1y' } }
      it { should compile }
    end
  end

  describe 'parameter validation fails' do
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
    context '$service_name should fail because it is not string' do
      let(:params) { { :service_name => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$service_running should fail because it is not boolean' do
      let(:params) { { :service_running => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$service_enabled should fail because it is not boolean' do
      let(:params) { { :service_enabled => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$init_settings_config should fail because it is not absolute path' do
      let(:params) { { :init_settings_config => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$init_settings_custom_settings should fail because it is not hash' do
      let(:params) { { :init_settings_custom_settings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
    context '$init_settings_custom_subsettings should fail because it is not hash' do
      let(:params) { { :init_settings_custom_subsettings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
    context '$certname should fail because it is not string' do
      let(:params) { { :certname => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$server should fail because it is not string' do
      let(:params) { { :server => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$ca_server should fail because it is not string' do
      let(:params) { { :ca_server => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$report should fail because it is not boolean' do
      let(:params) { { :report => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$report_server should fail because it is not string' do
      let(:params) { { :report_server => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$environment should fail because it is not string' do
      let(:params) { { :environment => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$priority should fail because it is not string' do
      let(:params) { { :priority => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /to be an Integer, got String/)
      end
    end
    context '$usecacheonfailure should fail because it is not boolean' do
      let(:params) { { :usecacheonfailure => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$runinterval should fail because it is not string' do
      let(:params) { { :runinterval => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$runinterval should fail because it is not ending with correct extension' do
      let(:params) { { :runinterval => '30weeks' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$waitforcert should fail because it is not string' do
      let(:params) { { :waitforcert => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$waitforcert should fail because it is not ending with correct extension' do
      let(:params) { { :waitforcert => '30weeks' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$daemonize should fail because it is not boolean' do
      let(:params) { { :daemonize => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$custom_settings should fail because it is not hash' do
      let(:params) { { :custom_settings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
  end

end
