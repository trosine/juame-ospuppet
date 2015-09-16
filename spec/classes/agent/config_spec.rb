require 'spec_helper'
describe 'ospuppet::agent::config' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::agent::config') }
  end

  describe 'subclasses should be included' do
    context 'should contain init_settings class' do
      it { should contain_class('ospuppet::agent::config::init_settings') }
    end
    context 'should contain settings class' do
      it { should contain_class('ospuppet::agent::config::settings') }
    end
  end

end
