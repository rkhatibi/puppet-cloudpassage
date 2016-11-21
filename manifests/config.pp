class cloudpassage::config {
  if $::kernel != 'windows' {
    $configure = "/opt/cloudpassage/bin/configure --api-key=${cloudpassage::agent_key} --read-only=${cloudpassage::audit_mode}"

    if $cloudpassage::tags != undef {
      $configure_command = "$configure --tag=${cloudpassage::tags} --server-label=${cloudpassage::server_label}"
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
