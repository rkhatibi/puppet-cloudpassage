# Cloudpassage Puppet

#### Table of Contents

1. [Overview](#overview)
1. [Usage](#usage)
1. [Reference](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
    * [Module dependencies](#module-dependencies)
1. [Development](#development)

## Overview

The cloudpassage module installs and configures the CloudPassage Halo agent.

## Usage

### Download CloudPassage Puppet Module to Puppet Master

```
cd /etc/puppetlabs/code/environments/production/modules
git clone https://github.com/cloudpassage/puppet-cloudpassage.git
mv puppet-cloudpassage cloudpassage 
```

All interaction with the cloudpassage module can be done through the main cloudpassage class in the manifest (/etc/puppetlabs/code/environments/production/manifests) on Pupper Master. Below are example classes for Linux and Windows servers to function. Please see later section for required parameters.

### Example for Linux servers

```
class { 'cloudpassage':
  agent_key => 'myagentkey',
}
```

### Example for Windows servers


```
class { 'cloudpassage':
         agent_key => 'myagentkey',
         package_file => 'cphalo-3.9.7-win64.exe',
         package_url => 'https://production.packages.cloudpassage.com/windows/cphalo-3.9.7-win64.exe',
         destination_dir => 'C:\\Users\Administrator\Downloads',
         server_label => 'puppet_windows',
         audit_mode => true
}
```

## Reference

### Classes

#### Public classes

* cloudpassage: Main class, includes all other classes.

#### Private classes

```
* cloudpassage::params: Handles the module's params and sets defaults.
* cloudpassage::install: Handles the packages.
* cloudpassage::config: Configures the cphalo daemon on installation.
* cloudpassage::service: Handles the cphalod service.
* cloudpassage::yum: Manages the cloudpassage yum repo where applicable.
* cloudpassage::apt: Manages the cloudpassage apt repo where applicable.
```

### Parameters

The following parameters are available in the `cloudpassage` class:

#### `agent_key` (Required)

The CloudPassage Agent key.

#### `audit_mode`

Controls the Halo Agent's "read-only" attribute

#### `destination_dir` (Windows only)

Controls where we'll download the installer EXE

#### `manage_repos` (Linux only)

Set to true by default, will add cloudpassage package repo for install

#### `package_ensure`

Controls the package resource's "ensure" attribute

#### `package_file` (Windows only)

Controls the filename of the installer EXE

#### `package_name`

Controls the package resource's "name" attribute

#### `package_url` (Windows only)

Base URL from which we'll download the installer EXE

#### `repo_ensure` (Linux only)

Controls the apt or yum repo's "ensure" attribute

#### `service_name`

The name of the service

#### `server_label`

Unique identifer of the VM

#### `tags`

The CloudPassage tags that this node will be configured with. If nothing is provided
will not include --tags in the agent registration process (default set to undef)

#### `proxy`

Proxing settings. To configure the agent to use an outbound pro

#### `proxy_user`

Proxy username

#### `proxy_password`

Proxy password

### `dns`

Controls DNS resolution (True | False)

## Limitations

### Module dependencies

This module uses the [puppetlabs-apt module](https://forge.puppet.com/puppetlabs/apt) for the management of the NodeSource
repository, [puppetlabs-stdlib module] and [puppetlabs-powershell module]

For Windows installations, this module uses the [puppet-download_file module](https://forge.puppet.com/puppet/download_file) to download the necessary installers.

## Development

We welcome contributions to this module from the Puppet community - the preferred way would be to send a pull request to the module repo on GitHub (https://github.com/cloudpassage/puppet-cloudpassage). Bonus points if you follow this process: 

1. Fork the module on github
1. pull it down
1. run the acceptance tests included in the module
1. make your changes
1. add spec tests to test your changes
1. then submit a pull request

This module is regularly reviewed and maintained by the CloudPassage integrations team. For any feedback, questions or support issues, please contact support@cloudpassage.com.

<!---
#CPTAGS:community-unsupported automation deployment
#TBICON:images/ruby_icon.png
-->
