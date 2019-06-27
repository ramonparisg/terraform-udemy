provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}

resource "aws_instance" "instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.simplekeypair.key_name}"
}

resource "aws_key_pair" "simplekeypair" {
  key_name   = "mykey"
  public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

output "public-ip" {
  value = "Public IP: ${aws_instance.instance.public_ip}"
}

