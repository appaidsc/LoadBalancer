resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Update path to your public key file
}

resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0437df53acb2bbbfd"  # Amazon Linux 2 in us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key_pair.key_name

  tags = {
    Name = "Terraform-Instance-${count.index + 1}"
  }
}
