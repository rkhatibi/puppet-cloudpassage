class cloudpassage::service {
  service { $cloudpassage::service_name:
    enable => $cloudpassage::service_enable,
    ensure => $cloudpassage::service_ensure,
  }
}
