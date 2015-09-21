require 'spec_helper'
describe 'ospuppet::agent::params' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  context 'catalog should compile' do
    it { should compile }
  end

  context 'unsupported $::osfamily should fail' do
    let (:facts) { { :osfamily => 'Darwin', :operatingsystem => 'Darwin', } }
    it do
      expect { catalogue }.to raise_error(Puppet::Error, /osfamily Darwin not supported/)
    end
  end

end
