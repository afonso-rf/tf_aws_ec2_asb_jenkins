variable "region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"

}

variable "instance_type" {
  description = "Tipo do shape da instancia"
  type        = string
  default     = "t2.micro"
}

variable "name" {
  description = "Nome da instancia"
  type        = string
  default     = "jenkins"
}

variable "env" {
  description = "Ambiente da aplicação"
  type        = string
  default     = "dev"
}
