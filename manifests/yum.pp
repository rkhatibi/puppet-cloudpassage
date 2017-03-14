# yum repo configurations
class cloudpassage::yum {
  yumrepo { 'cloudpassage':
    ensure   => $cloudpassage::repo_ensure,
    baseurl  => "http://packages.cloudpassage.com/redhat/${::basearch}",
    descr    => 'CloudPassage',
    gpgcheck => 1,
    gpgkey   => 'https://production.packages.cloudpassage.com/cloudpassage.packages.key'
  }

  Yumrepo['cloudpassage'] -> Class['cloudpassage::install']
}
