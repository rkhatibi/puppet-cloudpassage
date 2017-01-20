class cloudpassage::config {
  if $::kernel != 'windows' {
    $configure = "/opt/cloudpassage/bin/configure --agent-key=${cloudpassage::agent_key} --read-only=${cloudpassage::audit_mode}"
    
    if ($cloudpassage::tag != undef) and ($cloudpassage::server_label != undef) {
      $configure_command = "$configure --tag=${cloudpassage::tag} --server-label=${cloudpassage::server_label}"
    } elsif $cloudpassage::server_label != undef {
      $configure_command = "$configure --server-label=${cloudpassage::server_label}"
    } elsif $cloudpassage::tag != undef {
      $configure_command = "$configure --tag=${cloudpassage::tag}"
    } else {
      $configure_command = $configure
    }

    exec { 'initialize cloudpassage':
      command     => $configure_command,
      logoutput   => on_failure,
      path        => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
      refreshonly => true,
    }
  }
}
