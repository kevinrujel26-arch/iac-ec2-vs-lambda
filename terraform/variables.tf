variable "aws_region" {
  description = "Region de AWS donde se despliega la comparativa"
  type        = string
  default     = "us-east-2"
}

variable "project" {
  description = "Prefijo para nombrar los recursos"
  type        = string
  default     = "comparativa"
}

variable "instance_type" {
  description = "Tipo de instancia EC2 (se elige CPU y RAM a mano)"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Tamano del disco raiz en GB (EBS gp3)"
  type        = number
  default     = 8
}

variable "lambda_memory_size" {
  description = "Memoria de la funcion Lambda en MB (la CPU escala con la memoria)"
  type        = number
  default     = 128
}

variable "lambda_timeout" {
  description = "Tiempo maximo de ejecucion de la funcion en segundos (maximo 900)"
  type        = number
  default     = 10
}

variable "log_retention_days" {
  description = "Dias que se guardan los logs de la Lambda en CloudWatch"
  type        = number
  default     = 7
}
