# Cloud Passage agent installation module
#
# Params
#
# agent_key       = the agent registration key you use to register the node
# audit_mode      = Controls the Halo Agent's "read-only" attribute
# destination_dir = (Windows only) Controls where we'll download the installer EXE
# dns             = Controls DNS resolution
# installdir      = The directory into which to install the agent
# manage_repos    = (Linux only) set to true by default, will add cloudpassage package repo for install
# nostart         = Specifies that the agent should not start up after installation.
# package_ensure  = controls the package resource's "ensure" attribute
# package_file    = (Windows only) controls the filename of the installer EXE
# package_name    = controls the package resource's "name" attribute
# package_url     = (Windows only) base URL from which we'll download the installer EXE
# proxy           = proxing settings. To configure the agent to use an outbound proxy
# proxy_user      = proxy user
# proxy_password  = proxy password
# repo_ensure     = (Linux only) controls the apt or yum repo's "ensure" attribute
# service_name    = the name of the service
# server_label    = unique identifer of the VM
# tag             = facts or values to use as tags for this node, if empty, tags will not be set

class cloudpassage(
  String $agent_key                       = undef,
  Boolean $audit_mode                     = false,
  Variant[String, Undef] $installdir      = undef,
  Variant[String, Undef] $destination_dir = 'c:/tmp',
  Boolean $dns                            = true,
  Boolean $manage_repos                   = true,
  String $package_ensure                  = 'present',
  Variant[String, Undef] $package_file    = 'cphalo-3.9.7-win64.exe',
  Variant[String, Undef] $package_url     = "https://production.packages.cloudpassage.com/windows/${package_file}",
  Variant[String, Undef] $proxy           = undef,
  Variant[String, Undef] $proxy_user      = undef,
  Variant[String, Undef] $proxy_password  = undef,
  Variant[String, Undef] $repo_ensure     = 'present',
  Boolean $service_enable                 = true,
  Boolean $service_ensure                 = true,
  Variant[String, Undef] $server_label    = undef,
  Variant[String, Undef] $tag             = undef
) {
  if $facts['kernel'] == 'Linux' {
      $package_name = 'cphalo'
      $service_name = 'cphalod'
    if $manage_repos == true {
      case $facts['os']['family'] {
        /(Debian)/:        { include cloudpassage::apt }
        /(RedHat)/: { include cloudpassage::yum }
        default: { fail("Unsupported operating system: ${facts['os']['family']}") }
      }
    }
  } elsif $facts['kernel'] == 'windows' {
      $package_name = 'CloudPassage Halo'
      $service_name = 'cphalo'
    if $package_ensure == 'absent' {
      $uninstall_options = ['/S']
    } else {
      $uninstall_options = undef
    }
  }

  if $package_ensure == 'absent' {
    include cloudpassage::service, cloudpassage::install
    Class['cloudpassage::service'] ~> Class['cloudpassage::install']
  } else {
    include cloudpassage::install, cloudpassage::config, cloudpassage::service
    Class['cloudpassage::install'] ~> Class['cloudpassage::config'] -> Class['cloudpassage::service']
  }
}
