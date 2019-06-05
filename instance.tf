resource "aws_key_pair" "ramon-key" {
  key_name   = "mykey"
  public_key = "${file(var.PATH_TO_PUBLIC_KEY)}"
}

resource "aws_instance" "example" {
  ami           = "${var.AMIS[var.AWS_REGION]}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ramon-key.key_name}"


  provisioner "file" {
    source      = "ramon.txt"
    destination = "~/ramon.txt"
  }

  connection {
    host        = "${coalesce(self.public_ip, self.private_ip)}"
    type        = "ssh"
    user        = "${var.INSTANCE_USERNAME}"
    private_key = "${file(var.PATH_TO_PRIVATE_KEY)}"
  }

}
