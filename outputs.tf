output "jenkins_pub_ip" {
  value = aws_instance.jenkins.public_ip
}
output "jenkins_private_ip" {
  value = aws_instance.jenkins.private_ip
}
output "nexus_pub_ip" {
  value = aws_instance.nexus.public_ip
}
output "nexus_private_ip" {
  value = aws_instance.nexus.private_ip
}
output "sonar_pub_ip" {
  value = aws_instance.sonar.public_ip
}
output "sonar_private_ip" {
  value = aws_instance.sonar.private_ip
}