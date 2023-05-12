
resource "aws_instance" "sonar" {
  ami = "ami-0aa2b7722dc1b5612" ##ubuntu 20.04
  security_groups = [ aws_security_group.sonar.name ]
  instance_type = "t3.medium"
  associate_public_ip_address = true
  key_name = aws_key_pair.MyKey.key_name
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  user_data = "${file("sonar_user_data.sh")}"
  tags = {
    Name = "Sonar-tf-Server"
  }
  iam_instance_profile = data.aws_iam_role.s3.name
#  provisioner "file" {
#    source = "sonar_user_data.sh"
#    destination = "/home/ubuntu/sonar_user_data.sh"
#  }
#  provisioner "remote-exec" {
#    inline = [ 
#      "chmod +x /home/ubuntu/sonar_user_data.sh",
#      "sudo bash /home/ubuntu/sonar_user_data.sh"
#     ]
#    
#  }
#  connection {
#    type = "ssh"
#    user = "ubuntu"
#    host = self.public_ip
#    private_key = local_file.local_key_pair.content
#  }
  depends_on = [ local_file.local_key_pair ]
}
