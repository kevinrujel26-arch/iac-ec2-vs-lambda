# Ejemplo de uso: EC2 vs Lambda con Terraform (+ Ansible en el servidor)

Despliega en una sola ejecucion:

- **EC2**: instancia Amazon Linux 2023. Al arrancar instala Ansible, que se ejecuta
  dentro del servidor y deja **nginx** publicando una pagina.
- **Lambda**: funcion Python que responde con datos de su entorno.

## Estructura

```
comparativa-ec2-lambda/
├── terraform/
│   ├── providers.tf        # proveedor AWS y archive
│   ├── variables.tf        # region, tipo de instancia, memoria y timeout de la Lambda
│   ├── ec2.tf              # SG, rol SSM, instancia (con user_data)
│   ├── user_data.sh.tpl    # instala ansible y ejecuta el playbook en local
│   ├── lambda.tf           # rol, log group, funcion
│   └── outputs.tf          # URL de EC2 y comando para invocar la Lambda
├── ansible/
│   ├── playbook.yml        # instala nginx, publica la pagina, deja el servicio activo
│   └── templates/index.html.j2
└── lambda/
    └── handler.py
```

## Comandos

Requisitos: Terraform >= 1.5, AWS CLI con credenciales (perfil o `aws sso login`).

```
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```

## Evidencia para el informe

1. Salida de `terraform apply` con los outputs.
2. **EC2**: abrir `ec2_url` en el navegador (esperar 2-3 minutos tras el apply).
   Debe verse la pagina con hostname, SO, vCPU y memoria tomados por Ansible.
3. **EC2** en la consola: tipo de instancia, security group (solo puerto 80), rol.
4. **Ansible** (opcional): consola EC2 -> Conectar -> Session Manager, y ejecutar
   `cat /var/log/ansible-run.log` para ver el resultado del playbook.
5. **Lambda**: ejecutar el comando de `lambda_invoke_command` y mostrar la respuesta.
6. **Lambda** en la consola: memoria, timeout, runtime, y logs en CloudWatch.

## Al terminar, destruir todo (EC2 cobra por hora encendida)

```
terraform destroy
```

## Notas

- Si la cuenta no tiene VPC por defecto: `aws ec2 create-default-vpc --region us-east-2`
- No se abre el puerto 22. Se administra con Session Manager (sin llaves SSH).
- Si cambias el playbook o la plantilla, `terraform apply` reemplaza la instancia
  (`user_data_replace_on_change = true`) y se vuelve a ejecutar Ansible.
