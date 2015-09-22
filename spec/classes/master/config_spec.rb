require 'spec_helper'
describe 'ospuppet::master::config' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::master": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::master::config') }
  end

  describe 'subclasses should be included' do
    context 'should contain ::config::hiera class' do
      it { should contain_class('ospuppet::master::config::hiera') }
    end
    context 'should contain ::config::settings class' do
      it { should contain_class('ospuppet::master::config::settings') }
    end
  end

  describe 'class relationship validation' do
    context 'class hiera should not notify server class service when server class not defined' do
      it { should_not contain_class('ospuppet::master::config::hiera').that_notifies('ospuppet::server::service')}
    end
    context 'class settings should not notify server class service when server class not defined' do
      it { should_not contain_class('ospuppet::master::config::settings').that_notifies('ospuppet::server::service')}
    end
    context 'class hiera and settings should notify server class service when server class defined' do
      let(:pre_condition) {
        'class { "ospuppet::server": }
        class { "ospuppet::master": }'
      }
      it { should contain_class('ospuppet::master::config::hiera').that_notifies('ospuppet::server::service')}
      it { should contain_class('ospuppet::master::config::settings').that_notifies('ospuppet::server::service')}
    end
  end

end
