# yum repo configurations
class cloudpassage::yum {
  yumrepo { 'cloudpassage':
    baseurl  => "https://production.packages.cloudpassage.com/redhat/\$basearch",
    descr    => 'CloudPassage',
    gpgcheck => 1,
    gpgkey   => 'https://production.packages.cloudpassage.com/cloudpassage.packages.key'
  }

  Yumrepo['cloudpassage'] -> Class['cloudpassage::install']
}
