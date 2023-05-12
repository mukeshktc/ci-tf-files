
resource "aws_instance" "jenkins" {
  ami = "ami-0aa2b7722dc1b5612" ##ubuntu 20.04
  security_groups = [ aws_security_group.jenkins.name ]
  instance_type = "t3.small"
  associate_public_ip_address = true
  key_name = aws_key_pair.MyKey.key_name
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
#  user_data = "${file("jenkins_user_data.sh")}"
  tags = {
    Name = "Jenkins-tf-Server"
  }
  iam_instance_profile = data.aws_iam_role.s3.name
  provisioner "file" {
    source = "jenkins_user_data.sh"
    destination = "/home/ubuntu/jenkins_user_data.sh"
  }
  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /home/ubuntu/jenkins_user_data.sh",
      "sh /home/ubuntu/jenkins_user_data.sh"
     ]
    
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = local_file.local_key_pair.content
  }
  depends_on = [ local_file.local_key_pair ]
}
