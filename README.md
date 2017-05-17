# vagrant-puppet4-gitlab

Work in progress

## Overview
This stack will spin up the following components:

- Puppet Server - Based on Puppet 4.1
- Foreman - 1.15 via forman-installer
- Gitlab server - Based on 9.0.x

Images used are Centos7 Based

## Requirements
Components used in the test build environment are as follows:
- Virtualbox - 5.1 was used
- Vagrant - 1.9.5 was used
- Vagrant Plugins:
  - puppet (4.10.0)
  - vagrant-hostmanager (1.8.6)
  - vagrant-puppet-install (4.1.0)
  - vagrant-r10k (0.4.1)
  - vagrant-share (1.1.8, system)
  - vagrant-vbguest (0.14.2)

## Initializing the stack

- Clone the repository
- Edit the nodes.json file accordingly to match your needs
- 'git submodule init' to initialize the control repo submodule
- 'git submodule update' to pull down the latest submodule
- 'vagrant up' to launch the stack

## Todo
- Sort out secure ssh key management using eyaml.  The following files need manual key inputs for now:
  - data/roles::puppetmasterrole.yaml
  - custom/profiles/manifests/puppetmasterprofile.pp
- Work on autosigning of puppet certs. Right now its turned off so you will need to manually connect gitlab to the puppet server in order to exchange certificates.  It can be enabled but destroying the instances will cause issues with expected stale certificates on the puppet master
- Automatically import the control repository and configure the r10k webook in gitlab.
