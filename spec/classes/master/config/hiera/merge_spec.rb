require 'spec_helper'
describe 'ospuppet::master::config::hiera::merge' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::master":
      hiera_merge_behavior => "deeper",
    }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::master::config::hiera::merge') }
  end

  describe 'puppet master default params used by config::hiera::merge' do
    context 'puppet master should contain package puppet-deep_merge and puppetserver-deep_merge' do
      it { should contain_package('puppet.deep_merge')
        .with_ensure('latest')
        .with_name('deep_merge')
        .with_provider('puppet_gem') }
      it { should contain_package('puppetserver.deep_merge')
        .with_ensure('latest')
        .with_name('deep_merge')
        .with_provider('puppetserver_gem') }
    end
  end

  describe 'puppet master specified params used by config::hiera::merge' do
    context 'puppet master should contain package puppet-deeper_merge and puppetserver-deeper_merge' do
      let(:pre_condition) {
        'class { "ospuppet::master":
          puppet_gem_provider         => "pe_puppet_gem",
          puppetserver_gem_provider   => "pe_puppetserver_gem",
          hiera_merge_package_name    => "deeper_merge",
          hiera_merge_package_version => "1.2.3",
        }'
      }
      it { should contain_package('puppet.deeper_merge')
        .with_ensure('1.2.3')
        .with_name('deeper_merge')
        .with_provider('pe_puppet_gem') }
      it { should contain_package('puppetserver.deeper_merge')
        .with_ensure('1.2.3')
        .with_name('deeper_merge')
        .with_provider('pe_puppetserver_gem') }
    end
  end

end
