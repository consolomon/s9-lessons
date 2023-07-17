import json
from typing import Dict, Optional
from confluent_kafka import Consumer, KafkaError


class KafkaConsumer:

    def error_callback(err):
        print(f'Something went wrong: {err}')

    def __init__(
        self,
        host: str,
        port: int,
        user: str,
        password: str,
        topic: str,
        group: str,
        cert_path: str
    ) -> None:
        
        params = {
            'bootstrap.servers': f'{host}:{port}',
            'security.protocol': 'SASL_SSL',
            'ssl.ca.location': cert_path,
            'sasl.mechanism': 'SCRAM-SHA-512',
            'sasl.username': user,
            'sasl.password': password,
            'group.id': group,
            'auto.offset.reset': 'earliest',
            'enable.auto.commit': False,
            'error_cb': self.error_callback,
            'debug': 'all',
            'client.id': 'someclientkey'
        }
        self.consumer = Consumer(params)
        self.consumer.subscribe([topic])

    def consume(self, timeout: float = 3.0) -> Optional[Dict]:
        try:
            msg = self.consumer.poll(timeout=timeout)
            val = msg.value().decode()
            return json.loads(val)
        except KafkaError:
            self.error_callback('try to consume and print message is failed')
            print(msg.error)
