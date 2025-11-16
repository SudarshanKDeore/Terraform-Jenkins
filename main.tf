# ============================
# Terraform EC2 Example
# ============================

# 1️⃣ Specify Terraform Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

# 2️⃣ Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"          # Change region if needed
# profile = "default"            # Your AWS CLI profile name
}

# 3️⃣ Create a Key Pair (optional)
resource "aws_key_pair" "example_key" {
  key_name   = "terraform-demo-key"
  public_key = file("${path.module}/id_rsa.pub")  # Make sure this file exists

}

# 4️⃣ Create a Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 5️⃣ Get default VPC (needed for SG)
data "aws_vpc" "default" {
  default = true
}

# 6️⃣ Create EC2 Instance
resource "aws_instance" "ec2_example" {
  ami           = "ami-0cae6d6fe6048ca2c"  # Amazon Linux 2 in us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.example_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Terraform-EC2"
  }
}

# 7️⃣ Output instance public IP
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ec2_example.public_ip
}