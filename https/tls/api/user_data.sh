#!/bin/bash
yum upgrade -y
yum install docker -y

usermod -aG docker ${whoami}
service docker start

docker run -d -p 5000:5000 guy1nTheChair/bridge-learn-1 --name api
