resource "aws_instance" "example" {
  ami           = "ami-0756fbca465a59a30"
  instance_type = "t2.micro"
}
