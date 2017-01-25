class cloudpassage::install {
  if $::kernel == 'Windows' {
    if $cloudpassage::package_ensure != 'absent' {
      download_file { 'Get cphalo.exe':
        destination_directory => $cloudpassage::destination_dir,
        notify                => Package[$cloudpassage::package_name],
        url                   => $cloudpassage::package_url,
      }
    }

    $configure = [
        "/S",
        "/agent-key=$cloudpassage::agent_key",
        "/tag=$cloudpassage::tag",
        "/read-only=$cloudpassage::audit_mode",
        "/server-label=$cloudpassage::server_label",
        "/DNS=$cloudpassage::dns",
        "/D=$cloudpassage::installdir",
    ]

    if ($cloudpassage::nostart == true) {
      $nostart_condition = ['/NOSTART']
    } else {
      $nostart_condition = []
    }

    $configure_command = concat($configure, $nostart_condition)

    package { $cloudpassage::package_name:
      ensure            => ">=$cloudpassage::package_ensure",
      install_options   => $configure_command,
      source => "$cloudpassage::destination_dir/$cloudpassage::package_file",
      uninstall_options => $cloudpassage::uninstall_options
    }
  } else {
    package { $cloudpassage::package_name:
      ensure => 'latest'
    }
  }
}
