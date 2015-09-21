require 'spec_helper'
describe 'ospuppet::master::params' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  context 'catalog should compile' do
    it { should compile }
  end

end
