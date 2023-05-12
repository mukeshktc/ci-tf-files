#!/bin/bash
sudo apt update
sudo apt install default-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sleep 60
sudo apt install openjdk-8-jdk -y
sudo apt install awscli -y
sudo systemctl stop jenkins       
sudo aws s3 cp s3://s3-test-cicd-project/jenkins-test.tar.gz /var/lib
sudo tar -xvzf /var/lib/jenkins-test.tar.gz --directory /var/lib
sudo systemctl start jenkins