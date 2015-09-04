require 'spec_helper'
describe 'ospuppet::server::config::puppetserver' do

  let (:facts) { {
    :osfamily => 'RedHat',
    :operatingsystem => 'CentOS',
  } }

  let(:pre_condition) do
    'class { "ospuppet::server": }'
  end

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server::config::webserver') }
  end

  describe 'webserver default config - resource hocon_setting validation with default parameters' do
    context 'should contain hocon_setting resource for $webserver_access_log_config value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-webserver-access-log-config')\
        .with_setting('webserver.access-log-config')\
        .with_value('/etc/puppetlabs/puppetserver/request-logging.xml') }
    end
    context 'should contain hocon_setting resource for $webserver_client_auth value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-webserver-client-auth')\
        .with_setting('webserver.client-auth')\
        .with_value('want') }
    end
    context 'should contain hocon_setting resource for $webserver_ssl_host value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-webserver-ssl-host')\
        .with_setting('webserver.ssl-host')\
        .with_value('0.0.0.0') }
    end
    context 'should contain hocon_setting resource for $webserver_ssl_port value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-webserver-ssl-port')\
        .with_setting('webserver.ssl-port')\
        .with_value('8140') }
    end
  end

  describe 'webserver custom settings' do
    context '$webserver_custom_settings used for parameter shutdown-timeout-seconds' do
      let(:pre_condition) do
        'class {
          "ospuppet::server": webserver_custom_settings => {
            "shutdown-timeout-seconds" => {
              "ensure"  => "present",
              "setting" => "webserver.shutdown-timeout-seconds",
              "value"   => "30",
              "type"    => "number",
            },
          },
        }'
      end
      it { should contain_hocon_setting('shutdown-timeout-seconds')\
        .with_setting('webserver.shutdown-timeout-seconds')\
        .with_value('30')
        .with_type('number') }
    end
  end

end
