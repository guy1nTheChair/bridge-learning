#!/bin/bash
yum upgrade -y
yum install docker -y

usermod -aG docker $(whoami)
service docker start

docker run -d -p 443:5000 -p 80:5000 guyinthechair/python-app-new