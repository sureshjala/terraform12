
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "my_sg"
  }
  depends_on = [
    aws_vpc.my_vpc
  ]
}
resource "aws_nat_gateway" "private" {
    count = terraform.workspace == "qa" ? 1:0
    allocation_id = aws_eip.publicip[0].id
    subnet_id = aws_subnet.subnet.id
    tags = {
      "Name" = "my_nat_gateway"
    }
    depends_on = [
      aws_vpc.my_vpc
    ]
  
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "public_route"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}
resource "aws_eip" "publicip" {
  count = terraform.workspace == "qa" ? 1:0
  instance = aws_instance.my_server[0].id
  vpc      = true
  
}
resource "aws_route_table" "private" {
  count = terraform.workspace == "qa" ? 1:0
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.private[0].id
  }
  tags = {
    "Name" = "private_route"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}
resource "aws_route_table_association" "association" {
  count = terraform.workspace == "default" ? 1:0
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.public.id
  depends_on = [
    aws_route_table.public
  ]
}
resource "aws_route_table_association" "association1" {
  count = terraform.workspace == "qa" ? 1:0
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.private[0].id
  depends_on = [
    aws_route_table.private
  ]
}