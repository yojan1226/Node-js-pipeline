resource "aws_instance" "node_server" {

  ami                         = "ami-0d176f79571d18a8f"
  instance_type               = "t2.xlarge"
  key_name                    = "awskey"   # existing AWS keypair name
  associate_public_ip_address = true

  tags = {
    Name = "Nodeserver"
  }
}
