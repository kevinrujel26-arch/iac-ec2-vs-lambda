output "ec2_instance_id" {
  description = "ID de la instancia (sirve para entrar por Session Manager)"
  value       = aws_instance.web.id
}

output "ec2_url" {
  description = "Pagina publicada por nginx, configurada con Ansible (esperar 2-3 min tras el apply)"
  value       = "http://${aws_instance.web.public_ip}"
}

output "lambda_function_name" {
  description = "Nombre de la funcion Lambda"
  value       = aws_lambda_function.hola.function_name
}

output "lambda_url" {
  description = "URL HTTPS publica de la Lambda; abrir en el navegador para invocarla"
  value       = aws_lambda_function_url.hola.function_url
}

output "lambda_invoke_command" {
  description = "Comando para ejecutar la Lambda y ver su respuesta"
  value       = "aws lambda invoke --function-name ${aws_lambda_function.hola.function_name} --region ${var.aws_region} --cli-binary-format raw-in-base64-out --payload '{\"nombre\":\"Grupo 03\"}' respuesta.json && cat respuesta.json"
}
