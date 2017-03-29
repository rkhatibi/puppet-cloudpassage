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
  Undef $tag              = undef
) { if $facts['kernel'] == 'windows' {
      $destination_dir = 'c:/tmp'
      $package_file    = 'cphalo-3.9.7-win64.exe'
      $package_name    = 'CloudPassage Halo'
      $package_url     = "https://production.packages.cloudpassage.com/windows/${package_file}"
      $service_name    = 'cphalo'
  } else {
      $manage_repos = true
      $package_name = 'cphalo'
      $service_name = 'cphalod'
      $repo_ensure  = 'present'
  }
}
