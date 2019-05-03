# cloudpassage agent parameters
class cloudpassage::config {
  if $facts['kernel'] != 'windows' {
    $configure = "/opt/cloudpassage/bin/configure --agent-key=${cloudpassage::agent_key} --read-only=${cloudpassage::audit_mode} --dns=${cloudpassage::dns}"

    if ($cloudpassage::tag) {
      $tag_condition = " --tag=${cloudpassage::tag}"
    } else {
      $tag_condition = ''
    }
    if ($cloudpassage::server_label) {
      $server_label_condition = " --server-label=${cloudpassage::server_label}"
    } else {
      $server_label_condition = ''
    }
    if ($cloudpassage::azure_id) and ($cloudpassage::server_label == undef) {
      $azure_label = sprintf('%s_%s', $cloudpassage::azure_id, $facts['hostname'])
      $azure_label_condition = " --server-label=${azure_label}"
    }
    if ($cloudpassage::proxy) {
      $proxy_condition = " --proxy=${cloudpassage::proxy}"
    } else {
      $proxy_condition = ''
    }
    if ($cloudpassage::proxy_user) {
      $proxy_user_condition = " --proxy-user=${cloudpassage::proxy_user}"
    } else {
      $proxy_user_condition = ''
    }
    if ($cloudpassage::proxy_password) {
      $proxy_password_condition = " --proxy-password=${cloudpassage::proxy_password}"
    } else {
      $proxy_password_condition = ''
    }

    $configure_command = "${configure}${tag_condition}${server_label_condition}${azure_label_condition}${proxy_condition}${proxy_user_condition}${proxy_password_condition}"

    exec { 'initialize cloudpassage':
      command     => $configure_command,
      logoutput   => on_failure,
      path        => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
      refreshonly => true,
    }
  }
}