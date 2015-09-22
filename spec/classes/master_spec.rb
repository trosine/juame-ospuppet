require 'spec_helper'
describe 'ospuppet::master' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  context 'catalog should compile' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::master') }
  end

  describe 'subclasses should be included' do
    context 'should contain params class' do
      it { should contain_class('ospuppet::master::params') }
    end
    context 'should contain config class' do
      it { should contain_class('ospuppet::master::config') }
    end
  end

  describe 'parameter validation' do
    context '$hiera_merge_behavior should match regex for native' do
      let(:params) { { :hiera_merge_behavior => 'native' } }
      it { should compile }
    end
    context '$hiera_merge_behavior should match regex for deep' do
      let(:params) { { :hiera_merge_behavior => 'deep' } }
      it { should compile }
    end
    context '$hiera_merge_behavior should match regex for deeper' do
      let(:params) { { :hiera_merge_behavior => 'deeper' } }
      it { should compile }
    end
    context '$hiera_merge_behavior should fail because it is not native, deep or deeper' do
      let(:params) { { :hiera_merge_behavior => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$hiera_logger should match regex for noop' do
      let(:params) { { :hiera_logger => 'noop' } }
      it { should compile }
    end
    context '$hiera_logger should match regex for puppet' do
      let(:params) { { :hiera_logger => 'puppet' } }
      it { should compile }
    end
    context '$hiera_logger should match regex for console' do
      let(:params) { { :hiera_logger => 'console' } }
      it { should compile }
    end
    context '$hiera_logger should fail because it is not noop, puppet or console' do
      let(:params) { { :hiera_logger => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
  end

  describe 'parameter validation fails' do
    context '$vardir should fail because it is not absolute path' do
      let(:params) { { :vardir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$logdir should fail because it is not absolute path' do
      let(:params) { { :logdir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$rundir should fail because it is not absolute path' do
      let(:params) { { :rundir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$pidfile should fail because it is not absolute path' do
      let(:params) { { :pidfile => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$hiera_config should fail because it is not absolute path' do
      let(:params) { { :hiera_config => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$hiera_backends should fail because it is not array' do
      let(:params) { { :hiera_backends => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an Array/)
      end
    end
    context '$hiera_hierarchy should fail because it is not array' do
      let(:params) { { :hiera_hierarchy => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an Array/)
      end
    end
    context '$hiera_yaml_datadir should fail because it is not absolute path' do
      let(:params) { { :hiera_yaml_datadir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$hiera_merge_package_name should fail because it is not string' do
      let(:params) { { :hiera_merge_package_name => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_merge_package_version should fail because it is not string' do
      let(:params) { { :hiera_merge_package_version => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_merge_behavior should fail because it is not string' do
      let(:params) { { :hiera_merge_behavior => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_logger should fail because it is not string' do
      let(:params) { { :hiera_logger => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_eyaml_package_version should fail because it is not string' do
      let(:params) { { :hiera_eyaml_package_version => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_eyaml_key_dir should fail because it is not absolute path' do
      let(:params) { { :hiera_eyaml_key_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$hiera_eyaml_extension should fail because it is not string' do
      let(:params) { { :hiera_eyaml_extension => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_eyaml_private_key should fail because it is not string' do
      let(:params) { { :hiera_eyaml_private_key => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$hiera_eyaml_public_key should fail because it is not string' do
      let(:params) { { :hiera_eyaml_public_key => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
  end

end
