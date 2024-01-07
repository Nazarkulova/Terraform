data "aws_route53_zone" "atyra_zone" {
  name         = "atyratechtorial.link"
  
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.atyra_zone.zone_id
  name    = "terraform.atyratechtorial.link"
  type    = "A"
  ttl     = "300"
  records =["152.90.224.47"]
}


resource "aws_vpc" "my_vpc_db" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC_database"
  }
}

resource "aws_subnet" "private_subnet" {
  count = 2

  vpc_id                  = aws_vpc.my_vpc_db.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false  # Private subnet

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "my-db-subnet-group_task"
  subnet_ids = aws_subnet.private_subnet[*].id
}

resource "aws_db_instance" "my_db_instance" {
  identifier          = "mydbinstance"
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  username            = "admin"
  password            = "Password22"  # Replace with your strong password
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group.name
  skip_final_snapshot = true

  vpc_security_group_ids = [aws_security_group.my_db_sg.id]

  tags = {
    Name = "MyDBInstance"
  }
}

resource "aws_security_group" "my_db_sg" {
  vpc_id = aws_vpc.my_vpc_db.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]  # Adjust as needed
}

/*resource "aws_dynamodb_table" "my_dynano_table" {
  name           = "MyDynamo"
  read_capacity  = 5  # Adjust as needed
  write_capacity = 5  # Adjust as needed

  attribute {
    name = "user_id"
    type = "S"  # String attribute type, you can use "N" for number, "B" for binary
  }

  attribute {
    name = "email"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "N"  # Assuming created_at is a numeric attribute (Unix timestamp, for example)
  }

  ttl {
    attribute_name = "ttl_attribute"  # Optional, specify if you want to enable TTL
    enabled        = true
  }

  global_secondary_index {
    name               = "EmailIndex"
    hash_key           = "email"
    range_key          = "created_at"
    read_capacity      = 5
    write_capacity     = 5
    projection_type    = "ALL"  # Adjust as needed (e.g., "INCLUDE" for specific attributes)
    non_key_attributes = ["additional_attribute"]  # Optional, list of non-key attributes to project
  }

  tags = {
    Name = "MyDynamoDBTable"
  }
}
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Dynamotask"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  attribute {
    name = "TopScore"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "GameTitleIndex"
    hash_key           = "GameTitle"
    range_key          = "TopScore"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}*/