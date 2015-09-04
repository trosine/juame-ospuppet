# ospuppet

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
  * [Setup requirements](#setup-requirements)
  * [Beginning with ospuppet](#beginning-with-ospuppet)
4. [Usage](#usage)
  * [Memory Allocation](#memory-allocation)
  * [Manage Puppet Server Service and stop Puppet Master](#manage-puppet-server-service-and-stop-puppet-master)
  * [Puppet Server should listen on specific IP and port](#puppet-server-should-listen-on-specific-ip-and-port)
  * [puppet-admin HTTP API Client Whitelist](#puppet-admin-http-api-client-whitelist)
  * [Add any setting to puppetserver.conf without specific parameter](#add-any-setting-to-puppetserverconf-without-specific-parameter)
5. [Reference](#reference)
  * [Classes](#classes)
  * [Defines](#defines)
  * [Parameters](#parameters)
    * [::ospuppet::server](#ospuppetserver)
6. [Limitations](#limitations)
7. [Development](#development)
  * [Running tests](#running-tests)

## Overview

The ospuppet module lets you use Puppet to install, configure and manage puppet itself.

## Module Description

The ospuppet module lets you use Puppet for following components:

  * Puppet Server (>2.0.0)

To manage the files in ini format the module uses the resources of the module [puppetlabs/inifile](https://forge.puppetlabs.com/puppetlabs/inifile). It uses the resources of the module [puppetlabs/hocon](https://forge.puppetlabs.com/puppetlabs/hocon) to manage the files in HOCON format.

### Puppet Server

The module lets you install, configure and manage the Puppet Server. Currently it's possible to manage the `init settings`, `puppetserver.conf` and `webserver.conf` configuration files. The class `::ospuppet::server ` does have parameters for the very standard settings in the mentioned configuration files. There are also hashes to add or manage other settings without dedicated parameters.

## Setup

### Setup requirements

Make sure that following modules are installed:
```
puppet module install puppetlabs-stdlib
puppet module install puppetlabs-inifile
puppet module install puppetlabs-hocon
```
Make sure that the necessary software packages are available for the package manager (like *yum*).
For example you can use the [Puppet Collections](https://docs.puppetlabs.com/guides/puppetlabs_package_repositories.html#using-puppet-collections).

### Beginning with ospuppet

The simplest way to get Puppet Server up and running with this module is...

```
include ::ospuppet::server
```

## Usage

### Memory Allocation
Use following parameters to change the Puppet Server memory allocation and to set the path to the java binary (*init settings*).
```
class { '::ospuppet::server':
  init_settings_java_bin         => '/usr/bin/java',
  init_settings_java_xms         => '512m',
  init_settings_java_xmx         => '512m',
  init_settings_java_maxpermsize => '256m',
}
```

### Manage Puppet Server Service and stop Puppet Master

This will make sure that the Puppet Server service is running and the service is enabled.
When `$service_manage_master` is set to true it will make sure that any Puppet Master service is stopped.
(It might be possible that an error occur when there's no Puppet Master service. I'm thinking about removing this.)

```
class { '::ospuppet::server':
  service_name          => 'running',
  service_running       => true,
  service_enabled       => true,
  service_manage_master => true,
}
```

### Puppet Server should listen on specific IP and port

Use the parameters `webserver_ssl_host` and `webserver_ssl_port` to specify the IP and port.
```
class { '::ospuppet::server':
  webserver_ssl_host => '0.0.0.0',
  webserver_ssl_port => '8140',
}
```

### puppet-admin HTTP API Client Whitelist

To manage the puppet-admin HTTP API Client Whitelist:
```
class { '::ospuppet::server':
  puppetserver_admin_client_whitelist => ['puppet.example.com', 'server.example.com'],
}
```

### Add any setting to puppetserver.conf without specific parameter

The hash `puppetserver_custom_settings` can be used to create any [hocon_setting](https://github.com/puppetlabs/puppetlabs-hocon#usage) resource.
```
class { '::ospuppet::server':
  puppetserver_max_active_instances => 1,
  puppetserver_custom_settings      => {
    'max-requests-per-instance' => {
      'ensure'  => 'present',
      'setting' => 'jruby-puppet.max-requests-per-instance',
      'value'   => '0',
      'type'    => 'number',
    },
    'authorization-required'    => {
      'ensure'  => 'present',
      'setting' => 'puppet-admin.authorization-required',
      'value'   => true,
      'type'    => 'boolean',
    },
  },
}

```

## Reference

### Classes

#### Public Classes

  * `::ospuppet` main class. Empty.
  * `::ospuppet::server` class to manage Puppet Server.

#### Private Classes

  * `::ospuppet::server::config` class for the configuration of the Puppet Server.
    * `::ospuppet::server::config::init_settings` manages the init settings.
    * `::ospuppet::server::config::puppetserver` manages the settings in the `puppetserver.conf`.
    * `::ospuppet::server::config::webserver` manages the settings in the `webserver.conf`.
  * `::ospuppet::server::install` class responsible for the installation of the Puppet Server.
  * `::ospuppet::server::service` this class manages the Puppet Server services.

### Parameters

#### ::ospuppet::server

##### `package_name`

Specifies the package to install. Valid options: a string containing a valid package name. Default: `puppetserver`.

##### `ensure_installed`

Specifies if Puppet Server should be installed. Valid options: a boolean. Default: `true`.

##### `package_version`

Specifies which version of the package should be installed. Valid options: a string containing a version. Default: `latest`.

##### `service_name`

Specifies the service name. Valid options: a string containing a valid service name. Default: `puppetserver`.

##### `service_running`

Specifies if the service is running. Valid options: a boolean. Default: `true`.

##### `service_enabled`

Specifies if the service is enabled. Valid options: a boolean. Default: `true`.

##### `service_manage_master`

Specifies if the Puppet Master service is managed. Managed means this module stops and disables the service. Valid options: a boolean. Default: `false`.

##### `config_dir`

Specifies the configuration directory of the Puppet Server installation. Parameter is also used for the init setting `CONFIG`. Valid options: a string containing an absolute path. Default: `/etc/puppetlabs/puppetserver/conf.d`.

##### `init_settings_config`

Specifies the init settings configuration file. Valid options: a string containing an absolute path. Default: `/etc/sysconfig/puppetserver` (RedHat) or `/etc/default/puppetserver` (Debian).

##### `init_settings_java_bin`

Specifies the path to the java binary (init setting `JAVA`). Valid options: a string containing an absolute path. Default: `/usr/bin/java`.

##### `init_settings_java_xms`

Specifies the Xms subsetting for the JVM in the init setting `JAVA_ARGS`. Valid options: a string containing a number and ends with `m` (megabyte) or `g` (gigabyte). Default: `2g`.

##### `init_settings_java_xmx`

Specifies the Xmx subsetting for the JVM in the init setting `JAVA_ARGS`. Valid options: a string containing a number and ends with `m` (megabyte) or `g` (gigabyte). Default: `2g`.

##### `init_settings_java_maxpermsize`

Specifies the MaxPermSize subsetting for the JVM in the init setting `JAVA_ARGS`. Valid options: a string containing a number and ends with `m` (megabyte) or `g` (gigabyte). Default: `256m`.

##### `init_settings_user`

Specifies the user for the Puppet Server processes in the init setting `user`. Valid options: a string containing a valid user name. Default: `puppet`.

##### `init_settings_group`

Specifies the group for the Puppet Server processes in the init setting `user`. Valid options: a string containing a valid group name. Default: `puppet`.

##### `init_settings_install_dir`

Specifies the installation directory of the Puppet Server installation in the init setting `INSTALL_DIR`. Valid options: a string containing an absolute path. Default: `/etc/puppetlabs/puppetserver/bootstrap.cfg`.

##### `init_settings_bootstrap_config`

Specifies the bootstrap configuration file for Puppet Server in the init setting `BOOTSTRAP_CONFIG`. Valid options: a string containing an absolute path. Default: `/etc/puppetlabs/puppetserver/bootstrap.cfg`.

##### `init_settings_service_stop_retries`

Specifies the number for the init setting `SERVICE_STOP_RETRIES`. Valid options: a number. Default: `60`.

##### `init_settings_custom_settings`

A hash for any init setting. Valid options: a hash containing a hash with a title, valid parameters and values. Default: `{}` (empty hash).

##### `init_settings_custom_subsettings`

A hash for any init (sub-)setting (like `JAVA_ARGS`) Valid options: a hash containing a hash with a title, valid parameters and values. Default: `{}` (empty hash).

##### `puppetserver_ruby_load_path`

Specifies the places for the puppet-agent dependencies like puppet, facter, etc. Valid options: an array containing an absolute path. Default: `['/opt/puppetlabs/puppet/lib/ruby/vendor_ruby']`.

##### `puppetserver_gem_home`

Specifies where JRuby will look for gems. Valid options: a string containing an absolute path. Default: `/opt/puppetlabs/server/data/puppetserver/jruby-gems`.

##### `puppetserver_master_conf_dir`

Specifies the path to puppet master configuration directory. Valid options: a string containing an absolute path. Default: `/etc/puppetlabs/puppet`.

##### `puppetserver_master_code_dir`

Specifies the path to puppet master code directory. Valid options: a string containing an absolute path. Default: `/etc/puppetlabs/code`.

##### `puppetserver_master_var_dir`

Specifies the path to puppet master var directory. Valid options: a string containing an absolute path. Default: `/opt/puppetlabs/server/data/puppetserver`.

##### `puppetserver_master_run_dir`

Specifies the path to puppet master run directory. Valid options: a string containing an absolute path. Default: `/var/run/puppetlabs/puppetserver`.

##### `puppetserver_master_log_dir`

Specifies the path to puppet master log directory. Valid options: a string containing an absolute path. Default: `/var/log/puppetlabs/puppetserver`.

##### `puppetserver_max_active_instances`

Specifies the maximum number of JRuby instances to allow. Valid options: a number. Default: `undef`.

##### `puppetserver_profiler_enabled`

Enables or disables profiling for the Ruby code. Valid options: a boolean. Default: `undef`.

##### `puppetserver_admin_client_whitelist`

Specifies the values for the puppet-admin HTTP API client whitelist. Valid options: an array containing strings with valid client certificate names. Default: `[]` (empty array).

##### `puppetserver_custom_settings`

A hash for any setting in the `puppetserver.conf`. Valid options: a hash containing a hash with a title, valid parameters and values. Default: `{}` (empty hash).

##### `webserver_access_log_config`

Specifies the path to an XML file containing configuration information for the Logback-access module. Valid options: a string containing an absolute path. Default: `/etc/puppetlabs/puppetserver/request-logging.xml`.

##### `webserver_client_auth`

Specifies the mode that the server uses to validate the client's certificate for incoming SSL connections. A string containing `none`, `need` or `want`. Default: `want`.

##### `webserver_ssl_host`

Sets the hostname to listen on for encrypted HTTPS traffic. Valid options: a string containing an IP address (or localhost). Default: `0.0.0.0`.

##### `webserver_ssl_port`

Sets the port to use for encrypted HTTPS traffic. Valid options: a string containing a valid port number. Default: `8140`.

##### `webserver_custom_settings`

A hash for any setting in the `webserver.conf`. Valid options: a hash containing a hash with a title, valid parameters and values. Default: `{}` (empty hash).

### Defines

## Limitations

The module is limited to Puppet 4.x releases and RedHat or CentOS Linux.

## Development

Pull Requests and [Issues](https://github.com/juame/juame-ospuppet/issues) are highly appreciated.

### Running tests

[![Build Status](https://travis-ci.org/juame/juame-ospuppet.svg?branch=master)](https://travis-ci.org/juame/juame-ospuppet)

This repository contains tests for rspec-puppet.

Quickstart:
```
gem install bundler
bundle install
bundle exec rake spec
```
