require 'spec_helper'
describe 'ospuppet::server::config::puppetserver' do

  let (:facts) { { :operatingsystem => 'CentOS' } }

  let(:pre_condition) do
    'class { "ospuppet::server": }'
  end

  context 'compilation with defaults for all parameters' do
    it { should compile }
  end

  context 'with defaults for all parameters' do
    it { should contain_class('ospuppet::server::config::puppetserver') }
  end

  describe 'puppetserver default config - resource hocon_setting validation with default parameters' do
    context 'should contain hocon_setting resource for ruby-load-path with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-ruby-load-path')\
        .with_setting('jruby-puppet.ruby-load-path')\
        .with_value(['/opt/puppetlabs/puppet/lib/ruby/vendor_ruby']) }
    end
    context 'should contain hocon_setting resource for gem-home with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-gem-home')\
        .with_setting('jruby-puppet.gem-home')\
        .with_value('/opt/puppetlabs/server/data/puppetserver/jruby-gems') }
    end
    context 'should contain hocon_setting resource for master-conf-dir with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-master-conf-dir')\
        .with_setting('jruby-puppet.master-conf-dir')\
        .with_value('/etc/puppetlabs/puppet') }
    end
    context 'should contain hocon_setting resource for master-code-dir with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-master-code-dir')\
        .with_setting('jruby-puppet.master-code-dir')\
        .with_value('/etc/puppetlabs/code') }
    end
    context 'should contain hocon_setting resource for master-var-dir with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-master-var-dir')\
        .with_setting('jruby-puppet.master-var-dir')\
        .with_value('/opt/puppetlabs/server/data/puppetserver') }
    end
    context 'should contain hocon_setting resource for master-run-dir with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-master-run-dir')\
        .with_setting('jruby-puppet.master-run-dir')\
        .with_value('/var/run/puppetlabs/puppetserver') }
    end
    context 'should contain hocon_setting resource for master-log-dir with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-master-log-dir')\
        .with_setting('jruby-puppet.master-log-dir')\
        .with_value('/var/log/puppetlabs/puppetserver') }
    end
    context 'should contain hocon_setting resource for max-active-instances with default value' do
      it { should_not contain_hocon_setting('ospuppet-puppetserver-max-active-instances')\
        .with_setting('jruby-puppet.max-active-instances')\
        .with_value('1') }
    end
    context 'should contain hocon_setting resource for profiler enabled with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-profiler-enabled')\
        .with_setting('profiler.enabled')\
        .with_value(false) }
    end
    context 'should contain hocon_setting resource for admin-client-whitelist with default value' do
      it { should contain_hocon_setting('ospuppet-puppetserver-client-whitelist')\
        .with_setting('puppet-admin.client-whitelist')\
        .with_value([]) }
    end
  end

  describe 'puppetserver default config - resource hocon_setting validation with specified parameters' do
    context 'should contain hocon_setting resource for ruby-load-path with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_ruby_load_path => ["/tmp/foobar/ruby"] }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-ruby-load-path')\
        .with_setting('jruby-puppet.ruby-load-path')\
        .with_value(['/tmp/foobar/ruby']) }
    end
    context 'should contain hocon_setting resource for gem-home with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_gem_home => "/tmp/foobar/gem_home" }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-gem-home')\
        .with_setting('jruby-puppet.gem-home')\
        .with_value('/tmp/foobar/gem_home') }
    end
    context 'should contain hocon_setting resource for master-conf-dir with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_master_conf_dir => "/tmp/foobar/conf" }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-master-conf-dir')\
        .with_setting('jruby-puppet.master-conf-dir')\
        .with_value('/tmp/foobar/conf') }
    end
    context 'should contain hocon_setting resource for master-code-dir with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_master_code_dir => "/tmp/foobar/code" }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-master-code-dir')\
        .with_setting('jruby-puppet.master-code-dir')\
        .with_value('/tmp/foobar/code') }
    end
    context 'should contain hocon_setting resource for master-var-dir with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_master_var_dir => "/tmp/foobar/var" }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-master-var-dir')\
        .with_setting('jruby-puppet.master-var-dir')\
        .with_value('/tmp/foobar/var') }
    end
    context 'should contain hocon_setting resource for master-run-dir with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_master_run_dir => "/tmp/foobar/run" }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-master-run-dir')\
        .with_setting('jruby-puppet.master-run-dir')\
        .with_value('/tmp/foobar/run') }
    end
    context 'should contain hocon_setting resource for master-log-dir with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_master_log_dir => "/tmp/foobar/log" }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-master-log-dir')\
        .with_setting('jruby-puppet.master-log-dir')\
        .with_value('/tmp/foobar/log') }
    end
    context 'should contain hocon_setting resource for max-active-instances with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_max_active_instances => 999 }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-max-active-instances')\
        .with_setting('jruby-puppet.max-active-instances')\
        .with_value('999') }
    end
    context 'should contain hocon_setting resource for profiler enabled with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_profiler_enabled => true }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-profiler-enabled')\
        .with_setting('profiler.enabled')\
        .with_value(true) }
    end
    context 'should contain hocon_setting resource for admin-client-whitelist with specified value' do
      let(:pre_condition) do
        'class { "ospuppet::server": puppetserver_admin_client_whitelist => ["clientcert.example.com"] }'
      end
      it { should contain_hocon_setting('ospuppet-puppetserver-client-whitelist')\
        .with_setting('puppet-admin.client-whitelist')\
        .with_value(['clientcert.example.com']) }
    end
  end

  describe 'puppetserver custom settings' do
    context '$puppetserver_custom_settings used for parameter max-requests-per-instance' do
      let(:pre_condition) do
        'class {
          "ospuppet::server": puppetserver_custom_settings => {
            "max-requests-per-instance" => {
              "ensure"  => "present",
              "setting" => "jruby-puppet.max-requests-per-instance",
              "value"   => "0",
              "type"    => "number",
            },
          },
        }'
      end
      it { should contain_hocon_setting('max-requests-per-instance')\
        .with_setting('jruby-puppet.max-requests-per-instance')\
        .with_value('0')
        .with_type('number') }
    end
  end

end
