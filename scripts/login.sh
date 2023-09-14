#!/bin/bash

pwd
echo "trying to enter"
cd infra
pwd
ssh -T -i ec2key ec2-user@PUBLIC_IP_1 

echo PUBLIC_IP_1
