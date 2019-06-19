provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example-01" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example-01"
  }
}
