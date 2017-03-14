# apt repo configurations
class cloudpassage::apt {
  include ::apt

  apt::source { 'cloudpassage':
    ensure   => $cloudpassage::repo_ensure,
    key      => {
      id     => '29AF0E02ACF0366976105511013FE82585F4BB98',
      source => 'https://production.packages.cloudpassage.com/cloudpassage.packages.key',
    },
    location => 'http://packages.cloudpassage.com/debian',
    notify   => Exec['apt_update'],
    release  => 'debian',
    repos    => 'main',
  }

  Exec['apt_update'] -> Class['cloudpassage::install']
}
