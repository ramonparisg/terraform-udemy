#Se crea con un "datasource" debido a que se usa templates predefinidos de cloudinits en Terraform.
data "template_file" "init-script" {
  template = "${file("scripts/init.cfg")}"
}

data "template_file" "shell-script" {
  template = "${file("scripts/volumes.sh")}"
  vars = { #Esta variable es enviada al archivo llamado arriba
    DEVICE = "${var.INSTANCE_DEVICE_NAME}"
  }
}

data "template_cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.init-script.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.shell-script.rendered}"
  }
}

