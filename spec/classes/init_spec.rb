require 'spec_helper'
describe 'ospuppet' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet') }
  end

  describe 'subclasses should be included' do
    context 'should contain params class' do
      it { should contain_class('ospuppet::params') }
    end
  end

  describe 'parameter validation fails' do
    context '$puppet_user should fail because it is not string' do
      let(:params) { { :puppet_user => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$puppet_group should fail because it is not string' do
      let(:params) { { :puppet_group => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$puppet_confdir should fail because it is not absolute path' do
      let(:params) { { :puppet_confdir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppet_config should fail because it is not string' do
      let(:params) { { :puppet_config => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$puppet_gem_provider should fail because it is not string' do
      let(:params) { { :puppet_gem_provider => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
  end

end
