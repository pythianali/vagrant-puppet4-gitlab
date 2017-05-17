#!/bin/sh

if [ ! -f /etc/provisioned ] ; then
  # install Puppet 4.x release repo
  /usr/bin/sudo /usr/bin/yum install -y /vagrant/puppetlabs-release-pc1-1.1.0-5.el7.noarch.rpm
  if [ $? -ne 0 ] ; then
    echo "Something went wrong installing the repository"
    exit 1
  fi

  # install / update puppet-agent
  /usr/bin/sudo  /usr/bin/yum install -y puppet-agent version='1.10.1-1.el7'
  if [ $? -ne 0 ] ; then
    echo "Something went wrong installing puppet-agent"
    exit 1
  else
    /usr/bin/sudo /opt/puppetlabs/bin/puppet agent -t
  fi
  touch /etc/provisioned
fi


# install Puppet 4.x server on puppetmaster
if [ "$HOSTNAME" = puppet.example.com ]; then 
  if [ ! -f /etc/serverprovisioned ] ; then
     echo "Installing Puppet/Foreman"
    /usr/bin/sudo /usr/bin/yum install -y epel-release
    /usr/bin/sudo /usr/bin/rpm -Uvh http://yum.theforeman.org/releases/1.15/el7/x86_64/foreman-release.rpm
    /usr/bin/sudo /usr/bin/yum install -y  foreman-installer
    /usr/bin/sudo /usr/sbin/foreman-installer --puppet-show-diff=true --foreman-puppetrun=true --foreman-proxy-puppetrun-provider=mcollective --foreman-proxy-manage-sudoersd=true --foreman-proxy-puppet
    if [ $? -ne 0 ] ; then
     echo "Something went wrong installing Puppet/Foreman"
     exit 1
    fi
  touch /etc/serverprovisioned
  fi
fi




