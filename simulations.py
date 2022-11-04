import boto3
import json
from fake_web_events import Simulation # biblioteca para simular eventos web, como cliques

# criando um cliente firehose
client = boto3.client('firehose', region_name='us-east-2')


def put_record(event):
    """
    Funcao que envia um evento para o firehose 
    """
    data = (json.dumps(event) + '\n').encode('utf-8') 
    response = client.put_record(
        # nome do stream
        DeliveryStreamName='igti-kinesis-firehose-s3-stream',
        # evento
        Record = {
            'Data': data
        }
    )
    print(event)
    return response

# criando as simulacoes, 100 usuarios fazendo 10000 sessoes por dia
simulation = Simulation(user_pool_size=100, sessions_per_day=10000)
# criando uma rodada de 300 segundos
events = simulation.run(duration_seconds=300)

for event in events:
    put_record(event) # para cada evento, subir no kinesis firehose