class cloudpassage::yum {
  yumrepo { 'cloudpassage':
    baseurl  => "http://packages.cloudpassage.com/redhat/\$basearch",
    descr    => 'CloudPassage production',
    ensure   => $cloudpassage::repo_ensure,
    gpgcheck => 1,
    gpgkey   => 'https://packages.cloudpassage.com/cloudpassage.packages.key',
  }

  Yumrepo['cloudpassage'] -> Class['cloudpassage::install']
}
