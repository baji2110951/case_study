#!/bin/bash

pwd
echo "trying to enter"
ssh -i ec2key ec2-user@PUBLIC_IP_1 

ip = PUBLIC_IP_1

echo $ip
