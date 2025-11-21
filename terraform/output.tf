output "ec2_public_ip" {
  value = aws_instance.myserver.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.myserver.private_ip
}

output "ssh_key" {
  value = "id_ed25519"
}
