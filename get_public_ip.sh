#!/bin/bash
pwd
cd infra
INSTANCE_ID=$(terraform output -raw ec2_instance_id)
PUBLIC_IP=$(terraform output -raw ec2_public_ip)

echo $INSTANCE_ID
echo $PUBLIC_IP

echo "Assign public Ip In Ansible host file"

pwd

cd ../config

pwd

sed -i "s/PUBLIC_IP/PUBLIC_IP_1/g" hosts

echo "sed is done"

sed -i "s/PUBLIC_IP_1/$PUBLIC_IP/g" ../scripts/login.sh
