
import json
from datetime import datetime
from logging import Logger
from typing import Dict, List

from app_config import AppConfig
from lib.kafka_connect import KafkaConsumer, KafkaProducer
from lib.redis import RedisClient

from stg_loader.repository import StgRepository


class StgMessageProcessor:

    def __init__(
        self,
        consumer: KafkaConsumer,
        producer: KafkaProducer,
        redis_client: RedisClient,
        stg_repository: StgRepository,
        batch_size: int,
        logger: Logger,
    ) -> None:
        self._consumer = consumer,
        self._producer = producer,
        self._redis = redis_client,
        self._stg_repository = stg_repository,
        self._logger = logger,
        self._batch_size = 100


    """
    def __init__(
        self,
        app_config: AppConfig,
        logger: Logger,
        batch_size = 100,
    ) -> None:
        self._consumer = app_config.kafka_producer(),
        self._producer = app_config.kafka_consumer(),
        self._redis = app_config.redis_client(),
        self._stg_repository = StgRepository(app_config.pg_warehouse_db()),
        self._batch_size = batch_size,
        self._logger = logger
    """

    # функция, которая будет вызываться по расписанию.
    def run(self) -> None:

        # Пишем в лог, что джоб был запущен.
        self._logger.info(f"{datetime.utcnow()}: START")

        # Запуск чтения сообщений в цикле
        for _ in range(self._batch_size):

            # Чтение сообщения из консьюмера Kafka
            message = self._consumer.consume()
            if not message:
                break
            self._logger.info(f"{datetime.utcnow()}: Message with object_id {message['object_id']} has received")

            # Запись сообщения в STG-слой Postgres
            self._stg_repository.order_events_insert(
                message['object_id'],
                message['object_type'],
                message['sent_dttm'],
                json.dumps(message['payload'])
            )

            # Чтение дополнительных данных о пользователе из Redis
            user_id = message['payload']['user']['id']
            user = self._redis.get(user_id)
            user_name = user['name']
            user_login = user['login']

            # Чтение дополнительных данных о ресторане из Redis
            restaurant_id = message['payload']['restaurant']['id']
            restaurant = self._redis.get(restaurant_id)
            restaurant_name = restaurant['name']

            # Формирование исходящего сообщения
            output_message = {
                "object_id": message['object_id'],
                "object_type": "order",
                "payload": {
                    'id': message['object_id'],
                    'date': message['payload']['date'],
                    'cost': message['payload']['cost'],
                    'payment': message['payload']['payment'],
                    'status': message['payload']['final_status'],
                    'restaurant': self._format_restaurant(restaurant_id, restaurant_name),
                    'user': self._format_user(user_id, user_name, user_login),
                    'products': self._format_items(message['payload']['order_items'], restaurant)
                }
            }

            # Отправка сообщения в продюсер Kafka
            self._producer.produce(output_message)
            self._logger.info(f"{datetime.utcnow()}. Message with object_id {message['object_id']} has Sent")

        # Пишем в лог, что джоб успешно завершен.
        self._logger.info(f"{datetime.utcnow()}: FINISH")

    
    def _format_restaurant(self, id, name) -> Dict[str, str]:

        return {
            "id": id,
            "name": name
        }

    def _format_user(self, id, name, login) -> Dict[str, str]:

        return {
            "id": id,
            "name": name,
            "login": login
        }
    
    def _format_items(self, order_items, restaurant) -> List[Dict[str, str]]:

        items = []
        menu = restaurant["menu"]

        for it in order_items:
            menu_item = next(x for x in menu if x["_id"] == it["id"])
            dst_it = {
                "id": it["id"],
                "price": it["price"],
                "quantity": it["quantity"],
                "name": menu_item["name"],
                "category": menu_item["category"]
            }
            items.append(dst_it)
 
        return items