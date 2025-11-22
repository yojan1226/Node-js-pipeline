resource "aws_instance" "node_server" {
  
  ami = "ami-0d176f79571d18a8f"
  instance_type = "t2.xlarge"
  key_name = aws_key_pair.ec2_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Nodeserver"
  }
}

resource "aws_key_pair" "ec2_key" {
    key_name = "awskey"
    public_key = file("$path.module}/terraform/keys/awskey.pub")
  
}