class cloudpassage::params {
  $agent_key      = undef
  $audit_mode     = false
  $dns            = true
  $installdir     = undef
  $nostart        = false
  $package_ensure = 'present'
  $proxy          = undef
  $proxy_user     = undef
  $proxy_password = undef
  $server_label   = undef
  $service_enable = true
  $service_ensure = true
  $tag            = undef

  if $::kernel == 'windows' {
    $destination_dir = 'c:/tmp'
    $package_file    = 'cphalo-3.9.7-win64.exe'
    $package_name    = 'CloudPassage Halo'
    $package_url     = "https://production.packages.cloudpassage.com/windows/$package_file"
    $service_name    = 'cphalo'
  } else {
    $manage_repos = true
    $package_name = 'cphalo'
    $service_name = 'cphalod'
    $repo_ensure  = 'present'
  }
}
