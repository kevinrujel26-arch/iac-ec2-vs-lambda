#!/bin/bash
set -euxo pipefail

dnf install -y ansible-core

mkdir -p /opt/ansible/templates
echo "${playbook_b64}" | base64 -d > /opt/ansible/playbook.yml

cd /opt/ansible
ansible-playbook -c local -i localhost, playbook.yml -e "app_env=${app_env}" \
  > /var/log/ansible-run.log 2>&1
