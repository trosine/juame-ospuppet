require 'spec_helper'
describe 'ospuppet::server::service' do

  let (:facts) { { :operatingsystem => 'CentOS' } }

  let(:pre_condition) do
    'class { "ospuppet::server": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server::service') }
  end

  describe 'service name validation' do
    context 'default service name should be puppetserver' do
      it { should contain_service('puppetserver') }
    end
    context 'service name should be set to ospuppet::server::service_name' do
      let(:pre_condition) do
        'class { "ospuppet::server": service_name => "foobar-srv" }'
      end
      it { should contain_service('foobar-srv') }
    end
  end

  describe 'service ensure validation' do
    context 'default value of ospuppet::server::service_running should be true' do
      it { should contain_service('puppetserver').with_ensure(true) }
    end
    context 'service ensure should be set to ospuppet::server::service_running' do
      let(:pre_condition) do
        'class { "ospuppet::server": service_running => false }'
      end
      it { should contain_service('puppetserver').with_ensure(false) }
    end
  end

  describe 'service enabled validation' do
    context 'default value of ospuppet::server::service_enabled should be true' do
      it { should contain_service('puppetserver').with_enable(true) }
    end
    context 'service ensure should be set to ospuppet::server::service_enabled' do
      let(:pre_condition) do
        'class { "ospuppet::server": service_enabled => false }'
      end
      it { should contain_service('puppetserver').with_enable(false) }
    end
  end

  describe 'verify service_manage_master' do
    context 'default service_manage_master is set to false and puppetmaster should be unmanaged' do
      it { should_not contain_service('puppetmaster') }
    end
    context 'ospuppet::server::service_manage_master is set to true and puppetmaster service should be disabled' do
      let(:pre_condition) do
        'class { "ospuppet::server": service_manage_master => true }'
      end
      it { should contain_service('puppetmaster').with({ "ensure" => "stopped", "enable" => "false" }) }
    end
  end

end
