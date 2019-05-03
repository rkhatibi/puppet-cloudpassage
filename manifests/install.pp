# Installation for windows and linux
class cloudpassage::install {
  if $facts['kernel'] == 'Windows' {
    if $cloudpassage::package_ensure != 'absent' {
      download_file { 'Get cphalo.exe':
        destination_directory => $cloudpassage::destination_dir,
        notify                => Package[$cloudpassage::package_name],
        url                   => $cloudpassage::package_url,
      }
    }
    if ($cloudpassage::azure_id) and ($cloudpassage::server_label == undef) {
      $server_label = sprintf('%s_%s', $cloudpassage::azure_id, $facts['hostname'])
    }
    if ($cloudpassage::server_label) {
      $server_label = $cloudpassage::server_label
    }

    package { $cloudpassage::package_name:
      ensure            => $cloudpassage::package_ensure,

      install_options   => [
        '/S',
        "/agent-key=${cloudpassage::agent_key}",
        "/tag=${cloudpassage::tag}",
        "/read-only=${cloudpassage::audit_mode}",
        "/server-label=${server_label}",
        "/DNS=${cloudpassage::dns}",
        "/D=${cloudpassage::installdir}",
      ],
      source            => "${cloudpassage::destination_dir}/${cloudpassage::package_file}",
      uninstall_options => $cloudpassage::uninstall_options
    }
  } else {
    package { $cloudpassage::package_name:
      ensure => $cloudpassage::package_ensure,
    }
  }
}
