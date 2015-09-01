require 'spec_helper'
describe 'ospuppet::server' do

  let(:facts) { { :operatingsystem => 'CentOS' } }

  context 'catalog should compile' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server') }
  end

  describe 'subclasses should be included' do
    context 'should contain install class' do
      it { should contain_class('ospuppet::server::install') }
    end
    context 'should contain config class' do
      it { should contain_class('ospuppet::server::config') }
    end
    context 'should contain service class' do
      it { should contain_class('ospuppet::server::service') }
    end
  end

  describe 'class relationship validation' do
    context 'class install should come before class config' do
      it { should contain_class('ospuppet::server::install').that_comes_before('ospuppet::server::config')}
    end
    context 'class config should notify class service' do
      it { should contain_class('ospuppet::server::config').that_notifies('ospuppet::server::service')}
    end
  end

  describe 'parameter validation' do
    context '$init_settings_java_xms should match regex for megabyte' do
      let(:params) { { :init_settings_java_xms => '64m' } }
      it { should compile }
    end
    context '$init_settings_java_xms should match regex for gigabyte' do
      let(:params) { { :init_settings_java_xms => '2g' } }
      it { should compile }
    end
    context '$init_settings_java_xmx should match regex for megabyte' do
      let(:params) { { :init_settings_java_xmx => '64m' } }
      it { should compile }
    end
    context '$init_settings_java_xmx should match regex for gigabyte' do
      let(:params) { { :init_settings_java_xmx => '2g' } }
      it { should compile }
    end
    context '$init_settings_java_maxpermsize should match regex for megabyte' do
      let(:params) { { :init_settings_java_maxpermsize => '64m' } }
      it { should compile }
    end
    context '$init_settings_java_maxpermsize should match regex for gigabyte' do
      let(:params) { { :init_settings_java_maxpermsize => '2g' } }
      it { should compile }
    end
    context '$init_settings_service_stop_retries should compile with numeric' do
      let(:params) { { :init_settings_service_stop_retries => '23' } }
      it { should compile }
    end
    context '$puppetserver_max_active_instances should compile with numeric' do
      let(:params) { { :puppetserver_max_active_instances => '23' } }
      it { should compile }
    end
    context '$webserver_client_auth should match regex for none' do
      let(:params) { { :webserver_client_auth => 'none' } }
      it { should compile }
    end
    context '$webserver_client_auth should match regex for need' do
      let(:params) { { :webserver_client_auth => 'need' } }
      it { should compile }
    end
    context '$webserver_client_auth should match regex for want' do
      let(:params) { { :webserver_client_auth => 'want' } }
      it { should compile }
    end
  end

  describe 'parameter validation fails' do
    context '$package_name should fail because it is not string' do
      let(:params) { { :package_name => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$ensure_installed should fail because it is not boolean' do
      let(:params) { { :ensure_installed => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$package_version should fail because it is not string' do
      let(:params) { { :package_version => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_java_bin should fail because it is not absolute path' do
      let(:params) { { :init_settings_java_bin => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$init_settings_java_xms should fail because it is not string' do
      let(:params) { { :init_settings_java_xms => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_java_xms should fail because it is not ending with m for megabyte' do
      let(:params) { { :init_settings_java_xms => '128MB' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$init_settings_java_xmx should fail because it is not string' do
      let(:params) { { :init_settings_java_xmx => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_java_xmx should fail because it is not ending with m for megabyte' do
      let(:params) { { :init_settings_java_xmx => '128MB' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$init_settings_java_maxpermsize should fail because it is not string' do
      let(:params) { { :init_settings_java_maxpermsize => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_java_maxpermsize should fail because it is not ending with m for megabyte' do
      let(:params) { { :init_settings_java_maxpermsize => '128MB' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$init_settings_user should fail because it is not string' do
      let(:params) { { :init_settings_user => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_group should fail because it is not string' do
      let(:params) { { :init_settings_group => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_install_dir should fail because it is not absolute path' do
      let(:params) { { :init_settings_install_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$config_dir should fail because it is not absolute path' do
      let(:params) { { :config_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$init_settings_bootstrap_config should fail because it is not absolute path' do
      let(:params) { { :init_settings_bootstrap_config => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$init_settings_service_stop_retries should fail because it is not numeric' do
      let(:params) { { :init_settings_service_stop_retries => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /Expected first argument to be a Numeric or Array/)
      end
    end
    context '$puppetserver_max_active_instances should fail because it is not numeric' do
      let(:params) { { :puppetserver_max_active_instances => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /Expected first argument to be a Numeric or Array/)
      end
    end
    context '$service_name should fail because it is not string' do
      let(:params) { { :service_name => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$service_enabled should fail because it is not boolean' do
      let(:params) { { :service_enabled => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$service_running should fail because it is not boolean' do
      let(:params) { { :service_running => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$service_manage_master should fail because it is not boolean' do
      let(:params) { { :service_manage_master => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$puppetserver_profiler_enabled should fail because it is not boolean' do
      let(:params) { { :puppetserver_profiler_enabled => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a boolean/)
      end
    end
    context '$puppetserver_admin_client_whitelist should fail because it is not array' do
      let(:params) { { :puppetserver_admin_client_whitelist => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an Array/)
      end
    end
    context '$puppetserver_ruby_load_path should fail because it is absolute path in array' do
      let(:params) { { :puppetserver_ruby_load_path => ['foo','bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppetserver_gem_home should fail because it is not absolute path' do
      let(:params) { { :puppetserver_gem_home => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppetserver_master_conf_dir should fail because it is not absolute path' do
      let(:params) { { :puppetserver_master_conf_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppetserver_master_code_dir should fail because it is not absolute path' do
      let(:params) { { :puppetserver_master_code_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppetserver_master_var_dir should fail because it is not absolute path' do
      let(:params) { { :puppetserver_master_var_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppetserver_master_run_dir should fail because it is not absolute path' do
      let(:params) { { :puppetserver_master_run_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$puppetserver_master_log_dir should fail because it is not absolute path' do
      let(:params) { { :puppetserver_master_log_dir => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$webserver_access_log_config should fail because it is not absolute path' do
      let(:params) { { :webserver_access_log_config => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not an absolute path/)
      end
    end
    context '$webserver_client_auth should fail because it is not string' do
      let(:params) { { :webserver_client_auth => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$webserver_client_auth should fail because it is not want, need or none' do
      let(:params) { { :webserver_client_auth => 'foobar' } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /does not match/)
      end
    end
    context '$webserver_ssl_host should fail because it is not string' do
      let(:params) { { :webserver_ssl_host => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$webserver_ssl_port should fail because it is not string' do
      let(:params) { { :webserver_ssl_port => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a string/)
      end
    end
    context '$init_settings_custom_settings should fail because it is not hash' do
      let(:params) { { :init_settings_custom_settings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
    context '$init_settings_custom_subsettings should fail because it is not hash' do
      let(:params) { { :init_settings_custom_subsettings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
    context '$puppetserver_custom_settings should fail because it is not hash' do
      let(:params) { { :puppetserver_custom_settings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
    context '$webserver_custom_settings should fail because it is not hash' do
      let(:params) { { :webserver_custom_settings => ['foo', 'bar'] } }
      it do
        expect { catalogue }.to raise_error(Puppet::Error, /is not a Hash/)
      end
    end
  end

end
