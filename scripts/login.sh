#!/bin/bash

pwd
echo "trying to enter"
cd infra
pwd
ssh -o StrictHostKeyChecking=no -i ec2key ec2-user@PUBLIC_IP_1 
ls -latr
echo PUBLIC_IP_1
