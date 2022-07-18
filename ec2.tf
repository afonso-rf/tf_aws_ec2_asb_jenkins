data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}


resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}_key"
  public_key = tls_private_key.sshkey.public_key_openssh
}


resource "aws_instance" "instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = aws_subnet.subnet_public.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.open_ports.id]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install python3 pip -y",
      "echo Done!"
    ]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.sshkey.private_key_pem

    }

  }

  tags = {
    Name        = var.name
    Environment = var.env
    Provisioner = "Terraform"
  }
}