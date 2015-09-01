require 'spec_helper'
describe 'ospuppet::server::config' do
  let (:facts) { { :operatingsystem => 'CentOS' } }

  let(:pre_condition) do
    'class { "ospuppet::server": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server::config') }
  end

  describe 'subclasses should be included' do
    context 'should contain initsettings class' do
      it { should contain_class('ospuppet::server::config::init_settings') }
    end
    context 'should contain puppetserver class' do
      it { should contain_class('ospuppet::server::config::puppetserver') }
    end
    context 'should contain puppetserver class' do
      it { should contain_class('ospuppet::server::config::webserver') }
    end
  end

end
