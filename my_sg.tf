resource "aws_security_group" "my_sg" {
    vpc_id = aws_vpc.my_vpc.id
    name = "my_sg"
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
    ingress {
    from_port        = 4200
    to_port          = 4200
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_sg"
  }
  depends_on = [
    aws_vpc.my_vpc
  ]
}
