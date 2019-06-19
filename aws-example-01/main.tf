# Provider
provider "aws" {
  region = "us-east-1"
}


# Variables
variable "server_port" {
  description = "Port the server will use for HTTP requests"
  default = 8080
}


# Resources
resource "aws_instance" "example-01" {
  ami           = "ami-40d28157"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.instance-01.id}"]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World..!" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags = {
    Name = "terraform-example-01"
  }
}

resource "aws_security_group" "instance-01" {
  name = "terraform-example-instance-01"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Outputs
output "public_ip" {
  value = "${aws_instance.example-01.public_ip}"
}
