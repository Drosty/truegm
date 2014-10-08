class site::app {

  file { '/home/vagrant/bin/setup_native.sh':
    ensure => present,
    mode => 775,
    source => '/vagrant/puppet/modules/site/files/setup_native.sh',
    replace => true,
    require => File['/home/vagrant/bin']
  }

  file { '/home/vagrant/truegm':
    ensure => symlink,
    target => '/vagrant',
    owner => 'vagrant',
    group => 'vagrant'
  }

  file { '/vagrant/config':
    ensure => directory,
    owner => 'vagrant',
    group => 'vagrant'
  }

  file { '/vagrant/config/database.yml.dist':
    ensure => present,
    source => '/vagrant/puppet/modules/site/files/database.yml',
    replace => false,
    require => File['/vagrant/config']
  }

  file { '/vagrant/config/database.yml':
    ensure => present,
    source => '/vagrant/config/database.yml.dist',
    replace => false,
    require => File['/vagrant/config/database.yml.dist']
  }

  file { '/home/vagrant/README.md':
    ensure => present,
    source => '/vagrant/puppet/modules/site/files/README.md',
    replace => true
  }

  file { '/home/vagrant/.bashrc':
    ensure => present,
    source => '/vagrant/puppet/modules/site/files/bashrc',
    replace => true
  }

  
  file { '/vagrant/.ruby-version':
    ensure => present,
    content => "ruby-2.1.2",
    replace => false,
    owner => 'vagrant',
    group => 'vagrant'
  }
  
}
