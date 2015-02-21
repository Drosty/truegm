class site::packages {

  package { 'build-essential':
    ensure => present
  }

  package { 'ntp':
    ensure => present
  }

  
  # Nokogiri dependencies
  package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
    ensure => present
  }

  # ImageScience dependencies
  package { 'libfreeimage-dev':
    ensure => present
  }

  # rmagick & paperclip dependencies
  package { [ 'imagemagick', 'libmagickwand-dev' ]:
    ensure => present
  }

  # capabara-webkit
  package { ['libqtwebkit-dev', 'qt4-qmake']:
    ensure => present
  }
  

  
  package { 'nodejs':
    ensure => present
  }
  

  
  package { ['vim', 'vim-nox']:
    ensure => present
  }
  

  

  

  
  package { 'redis-server':
    ensure => present
  }
  

  

  
  package { 'git-flow':
    ensure => present
  }
  

}
