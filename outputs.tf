output "public_ip" {
  description = "Acesso via SSH a instancia EC2"

  value = format(
    "\n ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -l ubuntu -p 22 -i %s %s \n",
    local_file.ssh_private_key.filename,
    aws_instance.instance.public_ip
  )
}

output "ansible_run" {
  description = "Linha para rodar o Ansible Playbook"

  value = format(
    "\n ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ubuntu -i '%s,' --private-key %s ansible/playbook.yml \n", aws_instance.instance.public_ip,
    local_file.ssh_private_key.filename
  )
}
