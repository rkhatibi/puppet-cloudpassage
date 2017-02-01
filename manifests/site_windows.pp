class { 'cloudpassage':
               agent_key => '15efc6fd864ce8471a71c5aa1000e06f',
               package_file => 'cphalo-3.9.7-win64.exe',
               package_url => 'https://production.packages.cloudpassage.com/windows/cphalo-3.9.7-win64.exe',
               destination_dir => 'C:\\Users\Administrator\Downloads',
               server_label => 'puppet_windows'
       }