# parameter options for cloudpassage agent
class cloudpassage::params(
  Undef $agent_key        = undef,
  Boolean $audit_mode     = false,
  Boolean $dns            = true,
  Undef $installdir       = undef,
  String $package_ensure  = 'present',
  Undef $proxy            = undef,
  Undef $proxy_user       = undef,
  Undef $proxy_password   = undef,
  Undef $server_label     = undef,
  Boolean $service_enable = true,
  Boolean $service_ensure = true,
  Undef $tag              = undef,
  Boolean $manage_repos   = true,
  String $destination_dir = 'c:/tmp',
  String $package_file    = 'cphalo-3.9.7-win64.exe',
  String $package_url     = "https://production.packages.cloudpassage.com/windows/${package_file}",
  String $repo_ensure     = 'present'
) { if $facts['kernel'] == 'windows' {
      $package_name    = 'CloudPassage Halo'
      $service_name    = 'cphalo'
  } else {
      $package_name    = 'cphalo'
      $service_name    = 'cphalod'
  }
}
