require 'spec_helper'
describe 'ospuppet::master::config::hiera' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::master": }'
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::master::config::hiera') }
  end

  describe 'subclasse eyaml should be included' do
    context 'should contain eyaml class by default' do
      it { should contain_class('ospuppet::master::config::hiera::eyaml') }
    end
    context 'should contain eyaml class when backend set' do
      let(:pre_condition) do
        'class { "ospuppet::master": hiera_backends => ["yaml", "eyaml"], }'
      end
      it { should contain_class('ospuppet::master::config::hiera::eyaml') }
    end
    context 'should not contain eyaml class when backend not set' do
      let(:pre_condition) do
        'class { "ospuppet::master": hiera_backends => ["yaml"], }'
      end
      it { should_not contain_class('ospuppet::master::config::hiera::eyaml') }
    end
  end

  describe 'subclass merge should be included' do
    context 'should contain merge class by default' do
      it { should contain_class('ospuppet::master::config::hiera::merge') }
    end
    context 'should contain merge class when hiera_merge_behavior is set to deep' do
      let(:pre_condition) do
        'class { "ospuppet::master": hiera_merge_behavior => "deep", }'
      end
      it { should contain_class('ospuppet::master::config::hiera::merge') }
    end
    context 'should contain merge class when hiera_merge_behavior is set to deeper' do
      let(:pre_condition) do
        'class { "ospuppet::master": hiera_merge_behavior => "deeper", }'
      end
      it { should contain_class('ospuppet::master::config::hiera::merge') }
    end
    context 'should contain merge class when hiera_merge_behavior is set to native' do
      let(:pre_condition) do
        'class { "ospuppet::master": hiera_merge_behavior => "native", }'
      end
      it { should_not contain_class('ospuppet::master::config::hiera::merge') }
    end
  end

  describe 'validation of file resources' do
    context 'should contain hiera.yaml configuration file' do
      it {should contain_file('/etc/puppetlabs/code/hiera.yaml')
        .with_ensure('file')
        .with_owner('puppet')
        .with_group('puppet')
        .with_mode('0644') }
    end
    context 'should contain hiera.yaml configuration file with specified parameters' do
      let(:pre_condition) {
        'class { "ospuppet":
          puppet_user         => "foo",
          puppet_group        => "bar",
        } ->
        class { "ospuppet::master":
          hiera_config => "/tmp/hiera/hiera.yaml"
        }'
      }
      it {should contain_file('/tmp/hiera/hiera.yaml')
        .with_ensure('file')
        .with_owner('foo')
        .with_group('bar')
        .with_mode('0644') }
    end
  end

end
