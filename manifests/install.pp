class cloudpassage::install {
  if $::kernel == 'Windows' {
    if $cloudpassage::package_ensure != 'absent' {
      download_file { 'Get cphalo.exe':
        destination_directory => $cloudpassage::destination_dir,
        notify                => Package[$cloudpassage::package_name],
        url                   => $cloudpassage::package_url,
      }
    }

    package { $cloudpassage::package_name:
      ensure            => $cloudpassage::package_ensure,
      install_options   => [
        "/S",
        "/agent-key=$cloudpassage::agent_key",
        "/tag=$cloudpassage::tags",
        "/read-only=$cloudpassage::audit_mode",
      ],
      uninstall_options => $cloudpassage::uninstall_options,
      source            => "$cloudpassage::destination_dir/$cloudpassage::package_file",
    }
  } else {
    package { $cloudpassage::package_name:
      ensure => $cloudpassage::package_ensure,
    }
  }
}
