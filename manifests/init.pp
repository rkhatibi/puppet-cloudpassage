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
  String $agent_key                       = $::cloudpassage::params::agent_key,
  Boolean $audit_mode                     = $::cloudpassage::params::audit_mode,
  Variant[String, Undef] $installdir      = $::cloudpassage::params::installdir,
  Variant[String, Undef] $destination_dir = $::cloudpassage::params::destination_dir,
  Boolean $dns                            = $::cloudpassage::params::dns,
  Boolean $manage_repos                   = $::cloudpassage::params::manage_repos,
  String $package_ensure                  = $::cloudpassage::params::package_ensure,
  Variant[String, Undef] $package_file    = $::cloudpassage::params::package_file,
  Variant[String, Undef] $package_name    = $::cloudpassage::params::package_name,
  Variant[String, Undef] $package_url     = $::cloudpassage::params::package_url,
  Variant[String, Undef] $proxy           = $::cloudpassage::params::proxy,
  Variant[String, Undef] $proxy_user      = $::cloudpassage::params::proxy_user,
  Variant[String, Undef] $proxy_password  = $::cloudpassage::params::proxy_password,
  Variant[String, Undef] $repo_ensure     = $::cloudpassage::params::repo_ensure,
  Boolean $service_enable                 = $::cloudpassage::params::service_enable,
  Boolean $service_ensure                 = $::cloudpassage::params::service_ensure,
  Variant[String, Undef] $service_name    = $::cloudpassage::params::service_name,
  Variant[String, Undef] $server_label    = $::cloudpassage::params::server_label,
  Variant[String, Undef] $tag             = $::cloudpassage::params::tag
) inherits ::cloudpassage::params {
  if $facts['kernel'] == 'Linux' {
    if $manage_repos == true {
      case $facts['os']['family'] {
        /(?i:debian|ubuntu)/:        { include cloudpassage::apt }
        /(?i:redhat|centos|fedora|amazon|oracle)/: { include cloudpassage::yum }
        default: { fail("Unsupported operating system: ${facts['os']['family']}") }
      }
    }
  } elsif $facts['kernel'] == 'windows' {
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
    Class['cloudpassage::install'] ~> Class['cloudpassage::config'] ~> Class['cloudpassage::service']
  }
}
