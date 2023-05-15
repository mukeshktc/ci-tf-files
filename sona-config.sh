sudo systemctl stop sonarqube
sudo apt install awscli -y
sudo aws s3 cp s3://s3-test-cicd-project/sonar-test.tgz /opt
sudo aws s3 cp s3://s3-test-cicd-project/postgres-test.tgz /var/lib
sudo tar -xvzf /opt/sonar-test.tgz --directory /opt
sudo tar -xvzf /var/lib/postgres-test.tgz --directory /var/lib
sudo systemctl start sonarqube