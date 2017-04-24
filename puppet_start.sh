#!/bin/bash
sudo apt-get install puppet facter librarian-puppet
# copy puppet files to /etc/puppet
sudo cp -rp etc/puppet/* /etc/puppet/
# install puppet modules
cd /etc/puppet
sudo librarian-puppet install
# apply puppet firewall manifest
sudo puppet apply /etc/puppet/manifests/firewall.pp
