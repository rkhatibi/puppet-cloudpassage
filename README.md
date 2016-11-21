# Cloudpassage

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

All interaction with the cloudpassage module can be done through the main cloudpassage class.
The `agentkey` parameter must be specified for the class to function.

```
class { 'cloudpassage':
  agentkey => 'myapikey',
}
```

## Reference

### Classes

#### Public classes

* cloudpassage: Main class, includes all other classes.

#### Private classes

* cloudpassage::params: Handles the module's params and sets defaults.
* cloudpassage::install: Handles the packages.
* cloudpassage::config: Configures the cphalo daemon on installation.
* cloudpassage::service: Handles the cphalod service.
* cloudpassage::yum: Manages the cloudpassage yum repo where applicable.
* cloudpassage::apt: Manages the cloudpassage apt repo where applicable.

### Parameters

The following parameters are available in the `cloudpassage` class:

#### `apikey`

The CloudPassage API key. This value is required.

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

## Limitations

### Module dependencies

This module uses the [puppetlabs-apt module](https://forge.puppet.com/puppetlabs/apt) for the management of the NodeSource
repository.

For Windows installations, this module uses the [puppet-download_file module](https://forge.puppet.com/puppet/download_file) to download the necessary installers.

<!---
#CPTAGS:community-unsupported automation deployment
#TBICON:images/ruby_icon.png
-->
