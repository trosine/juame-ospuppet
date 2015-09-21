require 'spec_helper'
describe 'ospuppet::master::config::hiera::eyaml' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::master":
      hiera_backends => ["yaml", "eyaml"],
    }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::master::config::hiera::eyaml') }
  end

  describe 'validation of file resources' do
    context 'should contain directory for keys' do
      it {should contain_file('/etc/puppetlabs/puppet/keys')
        .with_ensure('directory')
        .with_owner('puppet')
        .with_group('puppet')
        .with_mode('0771')
        .with_before('Exec[ospuppet.ospuppet::master::config::hiera::eyaml.createkeys]') }
    end
    context 'should contain directory for keys with specified params' do
      let(:pre_condition) {
        'class { "ospuppet::master":
          hiera_backends      => ["yaml", "eyaml"],
          puppet_user         => "foobar",
          puppet_group        => "foobar",
          hiera_eyaml_key_dir => "/tmp/keys",
        }'
      }
      it {should contain_file('/tmp/keys')
        .with_ensure('directory')
        .with_owner('foobar')
        .with_group('foobar')
        .with_mode('0771')
        .with_before('Exec[ospuppet.ospuppet::master::config::hiera::eyaml.createkeys]') }
    end
  end

  describe 'validation of exec resources' do
    context 'should contain exec resource to create key' do
      it {should contain_exec('ospuppet.ospuppet::master::config::hiera::eyaml.createkeys')
        .with_path('/opt/puppetlabs/puppet/bin')
        .with_command('eyaml createkeys --pkcs7-private-key=/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem --pkcs7-public-key=/etc/puppetlabs/puppet/keys/public_key.pkcs7.pem')
        .with_user('puppet')
        .with_creates('/etc/puppetlabs/puppet/keys/private_key.pkcs7.pem')
        .with_logoutput(true)
        .with_require('Package[puppet.hiera-eyaml]') }
    end
    context 'should contain exec resource to create key with specified params' do
      let(:pre_condition) {
        'class { "ospuppet::master":
          hiera_backends          => ["yaml", "eyaml"],
          puppet_user             => "foobar",
          hiera_eyaml_key_dir     => "/tmp/keys",
          hiera_eyaml_private_key => "private.key",
          hiera_eyaml_public_key  => "public.key",
        }'
      }
      it {should contain_exec('ospuppet.ospuppet::master::config::hiera::eyaml.createkeys')
        .with_path('/opt/puppetlabs/puppet/bin')
        .with_command('eyaml createkeys --pkcs7-private-key=/tmp/keys/private.key --pkcs7-public-key=/tmp/keys/public.key')
        .with_user('foobar')
        .with_creates('/tmp/keys/private.key')
        .with_logoutput(true)
        .with_require('Package[puppet.hiera-eyaml]') }
    end
  end

  describe 'validation of package resources' do
    context 'puppet master should contain package hiera-eyaml' do
      it { should contain_package('puppet.hiera-eyaml')
        .with_ensure('latest')
        .with_name('hiera-eyaml')
        .with_provider('puppet_gem') }
      it { should contain_package('puppetserver.hiera-eyaml')
        .with_ensure('latest')
        .with_name('hiera-eyaml')
        .with_provider('puppetserver_gem') }
    end
    context 'puppet master should contain package eyaml version 1.2.3' do
      let(:pre_condition) {
        'class { "ospuppet":
          puppet_gem_provider         => "pe_puppet_gem",
          puppetserver_gem_provider   => "pe_puppetserver_gem",
        } ->
        class { "ospuppet::master":
          hiera_backends              => ["yaml", "eyaml"],
          hiera_merge_package_name    => "eyaml",
          hiera_merge_package_version => "1.2.3",
        }'
      }
      it { should contain_package('puppet.eyaml')
        .with_ensure('1.2.3')
        .with_name('eyaml')
        .with_provider('pe_puppet_gem') }
      it { should contain_package('puppetserver.eyaml')
        .with_ensure('1.2.3')
        .with_name('eyaml')
        .with_provider('pe_puppetserver_gem') }
    end
  end

end
