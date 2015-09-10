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
    context 'should contain initsettings class' do
      it { should contain_class('ospuppet::master::config::hiera') }
    end
  end

  describe 'class relationship validation' do
    context 'class hiera should not notify server class service when server class not defined' do
      it { should_not contain_class('ospuppet::master::config::hiera').that_notifies('ospuppet::server::service')}
    end
    context 'class hiera should notify server class service when server class defined' do
      let(:pre_condition) {
        'class { "ospuppet::server": }
        class { "ospuppet::master": }'
      }
      it { should contain_class('ospuppet::master::config::hiera').that_notifies('ospuppet::server::service')}
    end
  end

end
