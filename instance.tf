resource "aws_instance" "instance1" {
  ami           = "ami-024a64a6685d05041"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"
}

output "public-ip" {
  value = "${aws_instance.instance1.public_ip}"
}

