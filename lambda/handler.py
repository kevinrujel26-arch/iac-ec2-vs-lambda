import json
import os
from datetime import datetime, timezone


def lambda_handler(event, context):
    """Funcion de ejemplo: devuelve datos del entorno donde se ejecuta."""
    nombre = (event or {}).get("nombre", "mundo")

    cuerpo = {
        "mensaje": f"Hola {nombre}, esta respuesta la genero AWS Lambda",
        "fecha_utc": datetime.now(timezone.utc).isoformat(),
        "entorno": os.environ.get("APP_ENV", "sin-definir"),
        "funcion": context.function_name,
        "memoria_mb": context.memory_limit_in_mb,
        "tiempo_restante_ms": context.get_remaining_time_in_millis(),
        "request_id": context.aws_request_id,
    }

    print(json.dumps(cuerpo)) 

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(cuerpo, ensure_ascii=False),
    }
