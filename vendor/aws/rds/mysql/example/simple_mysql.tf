# Networking stuff to isolate this example.  This will be provided to you by the networking team in most cases
# Creates a VPC with CIDR of 10.255.255.192/26(only 64 ip addresses)
resource "aws_vpc" "mysql_vpc_test" {
    cidr_block = "10.255.255.192/26"

    tags {
      Name        = "Test"
      Description = "Terraform Test that will be deleted"
      Environment = "test"
      Creator     = "${var.tag_creator}"
      Customer    = "${var.tag_customer}"
      Owner       = "${var.tag_owner}"
      Product     = "${var.tag_product}"
      Costcenter  = "${var.tag_costcenter}"
    }
}

# Creates a Subnet in Availability Zone A with 11 ip addresses
resource "aws_subnet" "mysql_subnet_a" {
  vpc_id                  = "${aws_vpc.mysql_vpc_test.id}"
  cidr_block              = "10.255.255.192/28"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags {
    Name        = "TestA"
    Description = "Terraform Test that will be deleted"
    Environment = "test"
    Creator     = "${var.tag_creator}"
    Customer    = "${var.tag_customer}"
    Owner       = "${var.tag_owner}"
    Product     = "${var.tag_product}"
    Costcenter  = "${var.tag_costcenter}"
  }
}

# Creates a Subnet in Availability Zone B with 11 ip addresses
resource "aws_subnet" "mysql_subnet_b" {
  vpc_id                  = "${aws_vpc.mysql_vpc_test.id}"
  cidr_block              = "10.255.255.208/28"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags {
    Name        = "TestB"
    Description = "Terraform Test that will be deleted"
    Environment = "test"
    Creator     = "${var.tag_creator}"
    Customer    = "${var.tag_customer}"
    Owner       = "${var.tag_owner}"
    Product     = "${var.tag_product}"
    Costcenter  = "${var.tag_costcenter}"
  }
}

# Creates a Subnet in Availability Zone C with 11 ip addresses
resource "aws_subnet" "mysql_subnet_c" {
  vpc_id                  = "${aws_vpc.mysql_vpc_test.id}"
  cidr_block              = "10.255.255.224/28"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"

  tags {
    Name        = "TestC"
    Description = "Terraform Test that will be deleted"
    Environment = "test"
    Creator     = "${var.tag_creator}"
    Customer    = "${var.tag_customer}"
    Owner       = "${var.tag_owner}"
    Product     = "${var.tag_product}"
    Costcenter  = "${var.tag_costcenter}"
  }
}

# Creates a Subnet in Availability Zone E with 11 ip addresses
resource "aws_subnet" "mysql_subnet_e" {
  vpc_id                  = "${aws_vpc.mysql_vpc_test.id}"
  cidr_block              = "10.255.255.240/28"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1e"

  tags {
    Name        = "TestE"
    Description = "Terraform Test that will be deleted"
    Environment = "test"
    Creator     = "${var.tag_creator}"
    Customer    = "${var.tag_customer}"
    Owner       = "${var.tag_owner}"
    Product     = "${var.tag_product}"
    Costcenter  = "${var.tag_costcenter}"
  }
}

# This is where the good stuff starts

# Creates a database subnet group that can access all the availability zones in us-east-1
resource "aws_db_subnet_group" "mysql_db_subnet_grp_test" {
  subnet_ids = ["${aws_subnet.mysql_subnet_a.id}", "${aws_subnet.mysql_subnet_b.id}", "${aws_subnet.mysql_subnet_c.id}", "${aws_subnet.mysql_subnet_e.id}"]

  tags {
    Name        = "mysql_db_subnet_grp_test"
    Description = "Terraform Test that will be deleted"
    Environment = "test"
    Creator     = "${var.tag_creator}"
    Customer    = "${var.tag_customer}"
    Owner       = "${var.tag_owner}"
    Product     = "${var.tag_product}"
    Costcenter  = "${var.tag_costcenter}"
  }
}

# Creates a security group for the mysql database
resource "aws_security_group" "mysql_sg_in_test" {
  vpc_id      = "${aws_vpc.refvpc.id}"

  # inbound RDS access only from ref-INSTANCE
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${aws_security_group.ref-INSTANCE.id}"]
  }

  tags {
    Name        = "mysql_sg_in_test"
    Description = "Terraform Test that will be deleted"
    Environment = "test"
    Creator     = "${var.tag_creator}"
    Customer    = "${var.tag_customer}"
    Owner       = "${var.tag_owner}"
    Product     = "${var.tag_product}"
    Costcenter  = "${var.tag_costcenter}"
  }
}

# actual RDS database creation
resource "aws_db_instance" "mysql_test" {
  identifier = "${var.CUSTOMER}-${var.PRODUCT}-${var.ENVIRONMENT}"
  allocated_storage = "5"
  engine = "mysql"
  engine_version = "5.6.27"
  instance_class = "db.t2.micro"
  name = "${var.CUSTOMER}_${var.PRODUCT}_${var.ENVIRONMENT}"
  username = "${var.DB_USERNAME}"
  password = "${var.DB_PASSWORD}"
  port = "3306"
  publicly_accessible = "false"
  vpc_security_group_ids = ["${aws_security_group.mysql_sg_in_test.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.mysql_db_subnet_grp_test.id}"
}
