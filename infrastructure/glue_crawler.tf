# criando uma database no glue
resource "aws_glue_catalog_database" "stream" {
  name = "streamingdb"
}

# criando um crawler no glue
resource "aws_glue_crawler" "stream" {
  database_name = aws_glue_catalog_database.stream.name # database criado no passo anterior
  name          = "firehose_stream_s3_crawler"
  role          = aws_iam_role.glue_role.arn # role criada no arquivo iam.tf

  # configurando o crawler -> buscar tudo na pasta firehose do bucket
  s3_target {
    path = "s3://${aws_s3_bucket.stream.bucket}/firehose/"
  }

  configuration = <<EOF
{
   "Version": 1.0,
   "Grouping": {
      "TableGroupingPolicy": "CombineCompatibleSchemas" }
}
EOF

  tags = {
    IES   = "IGTI",
    CURSO = "EDC"
  }
}