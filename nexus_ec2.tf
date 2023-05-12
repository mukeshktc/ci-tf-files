
resource "aws_instance" "nexus" {
  ami = "ami-0fa1de1d60de6a97e" ##Amazon_linux_2
  security_groups = [ aws_security_group.nexus.name ]
  instance_type = "t3.medium"
  associate_public_ip_address = true
  key_name = aws_key_pair.MyKey.key_name
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  user_data = "${file("nexus_user_data.sh")}"
  tags = {
    Name = "Nexus-tf-Server"
  }
  iam_instance_profile = data.aws_iam_role.s3.name
#  provisioner "file" {
#    source = "nexus_user_data.sh"
#    destination = "/home/ec2-user/nexus_user_data.sh"
#  }
#  provisioner "remote-exec" {
#    inline = [ 
#      "chmod +x /home/ec2-user/nexus_user_data.sh",
#      "sudo bash /home/ec2-user/nexus_user_data.sh"
#     ]
    
#  }
#  connection {
#    type = "ssh"
#    user = "ec2-user"
#    host = self.public_ip
#    private_key = local_file.local_key_pair.content
#  }
  depends_on = [ local_file.local_key_pair ]
}
