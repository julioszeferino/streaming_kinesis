# recurso grupo de log do cloudwatch
resource "aws_cloudwatch_log_group" "firehose" {
  name              = "kinesis-firehose-delivery-stream-log-group"
  retention_in_days = 1 # serao retidos ate 1 dia

  tags = {
    IES   = "IGTI"
    CURSO = "EDC"
  }
}

# recurso stream de log do cloudwatch
# criado dentro do grupo de log criado acima
resource "aws_cloudwatch_log_stream" "firehose" {
  name           = "kinesis-firehose-delivery-stream-log-stream"
  log_group_name = aws_cloudwatch_log_group.firehose.name
}