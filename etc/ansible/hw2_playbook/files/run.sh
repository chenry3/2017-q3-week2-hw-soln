#!/bin/bash

# install pre-reqs
apt-get install ansible
# install code from repo to host
sudo cp -rp etc/ansible/* /etc/ansible/
# install ansible-galaxy requirements
sudo ansible-galaxy install -r /etc/ansible/requirements.yml
# execute hw2 playbook to install apache
ansible-playbook /etc/ansible/hw2_playbook.yml -s
# test https to localhost
curl -v -k https://localhost/hw2.txt
