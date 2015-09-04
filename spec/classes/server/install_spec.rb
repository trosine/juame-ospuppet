require 'spec_helper'
describe 'ospuppet::server::install' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::server": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server::install') }
  end

  context 'class should have one package resource' do
    it { should have_package_resource_count(1) }
  end

  describe 'package name validation' do
    context 'class should install package puppetserver with default parameter for ospuppet::server::package_name' do
      it { should contain_package('puppetserver') }
    end
    context 'class should install package with name of ospuppet::server::package_name' do
      let(:pre_condition) do
        'class { "ospuppet::server": package_name => "foobar-pkg" }'
      end
      it { should contain_package('foobar-pkg') }
    end
  end

  describe 'package version validation' do
    context 'class should install latest package with default parameter for ospuppet::server::package_version' do
      it { should contain_package('puppetserver').with_ensure('latest') }
    end
    context 'class should install package with version of ospuppet::server::package_version' do
      let(:pre_condition) do
        'class { "ospuppet::server": package_version => "2.3.1" }'
      end
      it { should contain_package('puppetserver').with_ensure('2.3.1') }
    end
    context 'class should remove package if ospuppet::server::ensure_installed is false' do
      let(:pre_condition) do
        'class { "ospuppet::server": ensure_installed => false }'
      end
      it { should contain_package('puppetserver').with_ensure('absent') }
    end
  end

end
