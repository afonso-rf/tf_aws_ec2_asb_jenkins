resource "tls_private_key" "sshkey" {

  algorithm = "ED25519"

}


resource "local_file" "ssh_private_key" {
  content         = tls_private_key.sshkey.private_key_openssh
  filename        = "id_ssh_key"
  file_permission = "0600"
}


resource "local_file" "ssh_public_key" {
  content         = tls_private_key.sshkey.public_key_openssh
  filename        = "id_ssh_key.pub"
  file_permission = "0600"
}

