resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet_GateWay_BH"
  }
}


resource "aws_eip" "HamzaBlertin_nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "aws_nat_gateway_natgw" {
  allocation_id = aws_eip.HamzaBlertin_nat_eip.id
  subnet_id     = aws_subnet.public_1.id

  tags = {
    Name = "Nat_GateWay_BH"
  }

}
