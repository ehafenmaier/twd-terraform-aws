provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example-01" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance-01.id}"]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World..!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example-01"
  }
}

resource "aws_security_group" "instance-01" {
  name = "terraform-example-instance-01"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}