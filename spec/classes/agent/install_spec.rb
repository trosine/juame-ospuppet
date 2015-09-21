require 'spec_helper'
describe 'ospuppet::agent::install' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::agent": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::agent::install') }
  end

  context 'class should have one package resource' do
    it { should have_package_resource_count(1) }
  end

  describe 'package name validation' do
    context 'class should install package puppet-agent with default parameter for ospuppet::agent::package_name' do
      it { should contain_package('puppet-agent') }
    end
    context 'class should install package with name of ospuppet::agent::package_name' do
      let(:pre_condition) do
        'class { "ospuppet::agent": package_name => "foobar-pkg" }'
      end
      it { should contain_package('foobar-pkg') }
    end
  end

  describe 'package version validation' do
    context 'class should install latest package with default parameter for ospuppet::agent::package_version' do
      it { should contain_package('puppet-agent').with_ensure('latest') }
    end
    context 'class should install package with version of ospuppet::agent::package_version' do
      let(:pre_condition) do
        'class { "ospuppet::agent": package_version => "2.3.1" }'
      end
      it { should contain_package('puppet-agent').with_ensure('2.3.1') }
    end
  end

end
