# resource "aws_instance" "instance1" {
#   ami           = "ami-024a64a6685d05041"
#   instance_type = "t2.micro"

#   # the VPC subnet
#   subnet_id = "${aws_subnet.main-public-1.id}"

#   # the security group
#   vpc_security_group_ids = [aws_security_group.allow-ssh.id]

#   # the public SSH key
#   key_name = "${aws_key_pair.mykeypair.key_name}"

#   user_data = data.template_cloudinit_config.cloudinit-example.rendered

#   depends_on = [aws_internet_gateway.main-gw]
# }

# resource "aws_eip" "example-ip" {
#   instance = "${aws_instance.instance1.id}"
#   vpc      = true
# }


# resource "aws_ebs_volume" "ebs-volume-1" {
#   availability_zone = "${var.AWS_REGION}a"
#   size              = 20
#   type              = "gp2"
#   tags = {
#     Name = "extra volume data"
#   }
# }

# resource "aws_volume_attachment" "ebs-volume-1-attachment" {
#   device_name  = "${var.INSTANCE_DEVICE_NAME}"
#   volume_id    = "${aws_ebs_volume.ebs-volume-1.id}"
#   instance_id  = "${aws_instance.instance1.id}"
#   skip_destroy = false
# }


# output "public-ip" {
#   value = "${aws_eip.example-ip.public_ip}"
# }

# output "rds" {
#   value = aws_db_instance.mariadb.endpoint
# }

