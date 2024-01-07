/*resource "aws_vpc" "my_vpc_project" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPCTask"
  }
}*/
/*
resource "aws_subnet" "private_subnet2" {
  count = 3

  vpc_id                  = aws_vpc.my_vpc_db.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = false  

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}
*/
/*resource "aws_instance" "my_instances" {
  count = 3

  ami             = "ami-00b8917ae86a424c9"  
  instance_type   = "t2.micro"
  subnet_id       = element(aws_subnet.private_subnet[*].id, count.index)
  key_name        = "local"  # Replace with your key pair name

  tags = {
    Name = "MyVPCTask-${count.index + 1}"
  }
}*/