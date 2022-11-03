# recurso para criar um stream no kinesis
resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = "igti-kinesis-firehose-s3-stream"
  destination = "extended_s3" # onde os dados serão colocados

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.stream.arn
    prefix = "firehose/" # caminho onde os dados serão colocados no s3
    buffer_size = 5 # tamanho do buffer em MB - tamanho dos lotes de entrega
    buffer_interval = 60 # intervalo de tempo em segundos para enviar os lotes de entrega
    
    # opcoes de log
    cloudwatch_logging_options {
        enabled = true
        log_group_name = aws_cloudwatch_log_group.firehose.name # nome do grupo de log
        log_stream_name = aws_cloudwatch_log_stream.firehose.name # nome do stream de log
    }
    
  }
}


# criando a role para o kinesis
# permite o acesso ao firehose
resource "aws_iam_role" "firehose_role" {
  name = "IGTI_firehose_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}