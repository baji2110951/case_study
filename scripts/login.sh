#!/bin/bash

pwd
echo "trying to enter"
cd infra
ssh -i ec2key ec2-user@PUBLIC_IP_1 

echo PUBLIC_IP_1
