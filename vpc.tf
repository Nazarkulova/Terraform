/* resource "aws_vpc" "my_vpc_task" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPCTask"
  }
}

resource "aws_subnet" "private_subnet" {
  count = 3

  vpc_id                  = aws_vpc.my_vpc_task.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = false  

  tags = {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}

/*resource "aws_instance" "my_instances" {
  count = 3

  ami             = "ami-00b8917ae86a424c9"  
  instance_type   = "t2.micro"
  subnet_id       = element(aws_subnet.private_subnet[*].id, count.index)
  key_name        = "local"  # Replace with your key pair name

  tags = {
    Name = "MyVPCTask-${count.index + 1}"
  }
}
*/
/*
# Define the launch template
resource "aws_launch_template" "my_launch_template" {
  name                 = "my_launch_template_task"
  image_id             = "ami-00b8917ae86a424c9" 
  instance_type        = "t2.micro"
  key_name             = "local" 

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      
    }
  }

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                  = aws_subnet.private_subnet[0].id 
  }
}

# Define the auto scaling group
resource "aws_autoscaling_group" "my_autoscaling_group" {
  desired_capacity     = 3
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier = aws_subnet.private_subnet[*].id

  launch_template {
    id      = aws_launch_template.my_launch_template.id
  }
  health_check_type = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout  = "15m"
  
  tag {
    key                 = "Name"
    value               = "My_Instance"
    propagate_at_launch = true
  }
  
}

# Define the EC2 instances
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]  # Adjust as needed
} */