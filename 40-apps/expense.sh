#!/bin/bash
dnf install ansible -y
cd /tmp
git clone https://github.com/makkenagithub/02-expense-ansible.git
cd 02-expense-ansible
ansible-playbook -i inventory.ini 01-mysql.yaml
ansible-playbook -i inventory.ini 02-backend.yaml
ansible-playbook -i inventory.ini 03-frontend.yaml