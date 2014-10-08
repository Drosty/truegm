class site::vim {

  file { '/home/vagrant/.vimrc':
    ensure => present,
    source => '/vagrant/puppet/modules/site/files/vimrc',
    replace => true,
    require => File['/home/vagrant/bin'],
    owner => 'vagrant',
    group => 'vagrant'
  }

  $vim_dirs = [
    '/home/vagrant/.vim',
    '/home/vagrant/.vim/_temp',
    '/home/vagrant/.vim/_backup'
  ]

  file { $vim_dirs:
    ensure => directory,
    require => File['/home/vagrant'],
    owner => 'vagrant',
    group => 'vagrant'
  }

}
