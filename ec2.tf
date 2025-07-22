resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Update path to your public key file
}
resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0437df53acb2bbbfd"  # Amazon Linux 2 (us-east-1)
  instance_type = "t3.micro"
  key_name      = aws_key_pair.my_key_pair.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Server $(hostname -f) is up</h1>" > /var/www/html/index.html
            EOF

  tags = {
    Name = "Terraform-Instance-${count.index + 1}"
  }
}
