import requests

DATA = {
  "student": "consolomon",
  "pg_settings": {
    "host": "rc1a-3ocskmeeutxi1eb8.mdb.yandexcloud.net",
    "port": 6432,
    "dbname": "sprint9dwh",
    "username": "consolomon",
    "password": "OnlyJustice3"
  }
}

def __main__():

    r = requests.post(
        url="https://postgres-check-service.sprint9.tgcloudenv.ru/init_schemas",
        json=DATA
    ).content

    result = r.decode("utf-8")
    with (open("/home/consolomon/YaPracticumLessons/s9-lessons/sandbox.json", "w")) as f:
        f.write(result)
        f.close()
    
    print(result)

if __name__ == "__main__":
    __main__()