class cloudpassage {

  # if you have your own apt/yum module you can comment these out
  # I recommends puppetlabs-apt for apt
  case $::osfamily {
    /(?i:debian)/: { include cloudpassage::apt }
    /(?i:redhat)/: { include cloudpassage::yum }
    default: {}
  }

  include cloudpassage::params, cloudpassage::data
  include cloudpassage::install, cloudpassage::firstart, cloudpassage::service

  Class['cloudpassage::install'] ~> Class['cloudpassage::firstart'] ~> Class['cloudpassage::service']

}
