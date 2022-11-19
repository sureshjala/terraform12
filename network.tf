resource "aws_vpc" "my_vpc" {
    cidr_block = var.cidr_block
  tags = {
    "Name" = "my_vpc"
  }
}
resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.my_vpc.id
    availability_zone = var.availability_zone
    cidr_block = var.cidr_block_subnet
    tags = {
      "Name" = "subnet1"
    }
}
