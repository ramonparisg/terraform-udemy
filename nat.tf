# La idea de la nat para las IP Privadas es para que estas puedan tener un punto de conexión al internet pero no haya puntos desde el internet hasta la red privada.
# Un caso de uso de este puede ser para obtener updates desde internet. Updates de bases de datos o de dependencias, se necesita solicitar datos de internet
# Pero no se podrá ingresar a las privadas a través de esta NAT

# nat gw
# Crea unas IP elásticas
resource "aws_eip" "nat" {
  vpc = true
}

# Crea unas NAT gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.main-public-1.id}"
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT
resource "aws_route_table" "main-private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
  }

  tags = {
    Name = "main-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = "${aws_subnet.main-private-1.id}"
  route_table_id = "${aws_route_table.main-private.id}"
}

resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = "${aws_subnet.main-private-2.id}"
  route_table_id = "${aws_route_table.main-private.id}"
}

resource "aws_route_table_association" "main-private-3-a" {
  subnet_id      = "${aws_subnet.main-private-3.id}"
  route_table_id = "${aws_route_table.main-private.id}"
}

