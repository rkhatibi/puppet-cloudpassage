class cloudpassage {

  case $::operatingsystem {
    /(?i:Ubuntu|Debian)/: { include cloudpassage::apt }
    /(?i:CentOS|RedHat|Fedora)/: { include cloudpassage::yum }
    default: {}
  }

  include cloudpassage::params, cloudpassage::data
  include cloudpassage::install, cloudpassage::firstart, cloudpassage::service

  Class['cloudpassage::install'] ~> Class['cloudpassage::firstart'] ~> Class['cloudpassage::service']

}
