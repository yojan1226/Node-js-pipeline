resource "aws_instance" "node_server" {
  
  ami = "ami-03695d52f0d883f65"
  instance_type = "t2.2xlarge"
  key_name = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Nodeserver"
  }
}

resource "aws_key_pair" "ec2_key" {
    key_name = "id_ed25519"
    public_key = file("$path.module}/terraform/keys/id_ed25519.pub")
  
}