class cloudpassage::config {
  if $::kernel != 'windows' {
    $configure = "/opt/cloudpassage/bin/configure --agent-key=${cloudpassage::agent_key} --read-only=${cloudpassage::audit_mode} --dns=${cloudpassage::dns}"

    if ($cloudpassage::tag != undef) {
      $tag_condition = " --tag=${cloudpassage::tag}"
    } else {
      $tag_condition = ''
    }
    if ($cloudpassage::server_label != undef) {
      $server_label_condition = " --server-label=${cloudpassage::server_label}"
    } else {
      $server_label_condition = ''
    }
    if ($cloudpassage::proxy != undef) {
      $proxy_condition = " --proxy=${cloudpassage::proxy}"
    } else {
      $proxy_condition = ''
    }
    if ($cloudpassage::proxy_user != undef) {
      $proxy_user_condition = " --proxy-user=${cloudpassage::proxy_user}"
    } else {
      $proxy_user_condition = ''
    }
    if ($cloudpassage::proxy_password != undef) {
      $proxy_password_condition = " --proxy-password=${cloudpassage::proxy_password"
    } else {
      $proxy_password_condition = ''
    }
    if ($cloudpassage::debug != false) {
      $debug_condition = " --debug"
    } else {
      $debug_condition = ''
    }

    $configure_command = "${configure}${tag_condition}${server_label_condition}${proxy_condition}${proxy_user_condition}${proxy_password_condition}${debug_condition}"

    exec { 'initialize cloudpassage':
      command     => $configure_command,
      logoutput   => on_failure,
      path        => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
      refreshonly => true,
    }
  }
}
