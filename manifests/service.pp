# ensure service is enabled
class cloudpassage::service {
  service { $cloudpassage::service_name:
    ensure => $cloudpassage::service_ensure,
    enable => $cloudpassage::service_enable
  }
}
