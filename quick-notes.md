AWS Kinesis
- Data Streams: servico de stream (topicos do kinesis [kafka])
- Data Firehouse: servico para fazer a entrega de dados dos topicos
- Data Analytics: processamento de dados em real-time

Projeto: Simular evendo




## Acessando na AWS
-> Kinesis > Delivery Streams


## Rodando o simulador
```
$ pip install requirements.txt
$ python simulations.py
```

- Ao terminar, o bucket no s3 contera varios dados.
- Clicar em run no crawler do aws glue para enviar os dados pro athena.
- Realizar as consultas necessarias no athena.