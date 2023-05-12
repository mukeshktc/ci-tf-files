
data "aws_vpc" "default" {
    default = true
}

##JENKINS SG
resource "aws_security_group" "jenkins" {
  name = "Jenkins-tf-SG"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allows ssh to jenkins"
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allows access jenkins dashboard"
  }
#  ingress {
#    from_port = 8080
#    to_port = 8080
#    protocol = "tcp"
#    security_groups = [aws_security_group.sonar.name]
#    description = "allows sonar to webhook and send quality gate result"
#  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
   tags = {
    Name = "Jenkins-tf-SG"
   }
}

#resource "aws_security_group_rule" "jenkins-dash" {
#  security_group_id = aws_security_group.jenkins.id
#  type = "ingress"
#  from_port = 8080
#  to_port = 8080
#  protocol = "tcp"
#  cidr_blocks = ["0.0.0.0/0"]
#}
resource "aws_security_group_rule" "jenkins-sonar" {
  security_group_id = aws_security_group.jenkins.id
  description = "allows sonar to webhook and send quality gate result"
  protocol = "tcp"
  from_port = 8080
  to_port = 8080
  source_security_group_id = aws_security_group.sonar.id
  type = "ingress"
}



##NEXUS SG

resource "aws_security_group" "nexus" {
  name = "Nexus-tf-SG"
  description = "SG for Nexus"
  vpc_id = data.aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allows ssh to nexus server"
  }
  ingress {
  from_port = 8081
  to_port = 8081
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "allows nexus and dashboard on web browser"
  }
  ingress {
    from_port = 8081
    to_port = 8081
    protocol = "tcp"
    security_groups = [aws_security_group.jenkins.id]
    description = "allows jenkins to upload artifact"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Nexus-tf-SG"
  }
}

#resource "aws_security_group_rule" "nexus-dash" {
#  security_group_id = aws_security_group.nexus.id
#  type = "ingress"
#  from_port = 8081
#  to_port = 8081
#  protocol = "tcp"
#  cidr_blocks = ["0.0.0.0/0"]
#  description = "allows nexus and dashboard on web browser"
#}
#resource "aws_security_group_rule" "nexus-jenkins" {
#  security_group_id = aws_security_group.nexus.id
#  type = "ingress"
#  from_port = 8081
#  to_port = 8081
#  protocol = "tcp"
#  source_security_group_id = aws_security_group.jenkins.id
#  description = "allows jenkins to upload artifact"
#}

## SONAR SG

resource "aws_security_group" "sonar" {
  name = "sonar-tf-sg"
  description = "SG for sonar server"
  vpc_id = data.aws_vpc.default.id
  ingress  {
    from_port = 22
    to_port = 22
    description = "ssh access to sonar server"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    from_port = 80
    to_port = 80
    description = "http access to sonar server"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
#  ingress  {
#    from_port = 80
#    to_port = 80
#    description = "jenkins access to sonar server"
#    protocol = "http"
#    security_groups = [aws_security_group.jenkins.name]
#  }   
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Sonar-tf-SG"
  }
}
#resource "aws_security_group_rule" "sonar-http" {
#  security_group_id = aws_security_group.sonar.id
#  type = "ingress"
#  description = "allows http from everywhere"
#  protocol = "tcp"
#  from_port = 80
#  to_port = 80
#  cidr_blocks = ["0.0.0.0/0"]
#}
resource "aws_security_group_rule" "sonar-jenkins" {
  security_group_id = aws_security_group.sonar.id
  type = "ingress"
  description = "allows jenkins to send test results to sonar"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  source_security_group_id = aws_security_group.jenkins.id
}



