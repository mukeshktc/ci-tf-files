resource "tls_private_key" "tf-private-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "MyKey" {
    key_name = "project-tf-key"
    public_key = tls_private_key.tf-private-key.public_key_openssh
}

## ON LINUX
#provisioner "local-exec" {
#    command = "echo '${tls_private_key.tf-private-key.private_key_pem}' > ./project-tf-key.pem"
#}

## ON WINDOWS
resource "local_file" "local_key_pair" {
    filename = "project-tf-key.pem"
    file_permission = "0400"
    content = tls_private_key.tf-private-key.private_key_pem
}