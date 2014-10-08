#!/bin/bash

# Installs packages necessary to install librarian-puppet gem
# to the vagrant basebox.

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR=/etc/puppet/

$(which apt-get > /dev/null 2>&1)
FOUND_APT=$?
$(which yum > /dev/null 2>&1)
FOUND_YUM=$?

INSTALL_PACKAGES=""

$(which git > /dev/null 2>&1)
FOUND_GIT=$?
if [ "$FOUND_GIT" -ne '0' ]; then
  INSTALL_PACKAGES="$INSTALL_PACKAGES git"
fi

$(which ruby > /dev/null 2>&1)
FOUND_RUBY=$?
if [ "$FOUND_RUBY" -ne '0' ]; then
  INSTALL_PACKAGES="$INSTALL_PACKAGES ruby"
fi

$(which make > /dev/null 2>&1)
FOUND_MAKE=$?
if [ "$FOUND_MAKE" -ne '0' ]; then
  # TODO: Allow to work on rpm based systems
  # Needs to be: yum groupinstall "Development Tools"
  INSTALL_PACKAGES="$INSTALL_PACKAGES build-essential"
fi

if [ "${FOUND_YUM}" -eq '0' ]; then
  $(yum list installed | grep -q ruby-develop 2>&1)
  FOUND_RUBY_DEV=$?
  if [ "$FOUND_RUBY_DEV" -ne '0' ]; then
    INSTALL_PACKAGES="$INSTALL_PACKAGES ruby-develop"
  fi
elif [ "${FOUND_APT}" -eq '0' ]; then
  $(dpkg --get-selections | grep -q ruby-dev 2>&1)
  FOUND_RUBY_DEV=$?
  if [ "$FOUND_RUBY_DEV" -ne '0' ]; then
    INSTALL_PACKAGES="$INSTALL_PACKAGES ruby-dev"
  fi
fi

if [ ! -z "$INSTALL_PACKAGES" ]; then
  if [ "${FOUND_YUM}" -eq '0' ]; then
    yum -q -y makecache
    yum -q -y install $INSTALL_PACKAGES
  elif [ "${FOUND_APT}" -eq '0' ]; then
    apt-get -q -y update
    apt-get -q -y upgrade
    apt-get -q -y install $INSTALL_PACKAGES
  else
    echo "No package installer available. You may need to install $INSTALL_PACKAGES manually."
  fi
fi

if [ ! -d "$PUPPET_DIR" ]; then
  mkdir -p $PUPPET_DIR
fi
cp /vagrant/puppet/Puppetfile $PUPPET_DIR

# Ensure we're using the system chruby
if [ -f /usr/local/share/chruby/chruby.sh ]; then
  source /usr/local/share/chruby/chruby.sh
  chruby system
fi

# Ensure puppet is installed
if [ "$(gem list -i '^puppet$')" = "false" ]; then
  gem install puppet --no-rdoc --no-ri
fi

if [ "$(gem list -i '^librarian-puppet$')" = "false" ]; then
  gem install librarian-puppet --no-rdoc --no-ri
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update
fi
