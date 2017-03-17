class { 'cloudpassage':
          agent_key       => $halo_agent_key,
          package_file    => 'cphalo-3.9.7-win64.exe',
          package_url     => 'https://production.packages.cloudpassage.com/windows/cphalo-3.9.7-win64.exe',
          destination_dir => 'C:\\Users\Administrator\Downloads',
          server_label    => 'puppet_windows'
      }