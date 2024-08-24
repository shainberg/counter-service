#!flask/bin/python
from config_map_updater import ConfigMapUpdater
from fastapi import FastAPI
import uvicorn

app = FastAPI()
counter = 0

NAMESPACE = 'default'  # replace with your namespace
CONFIG_MAP = 'counter-service'  # replace with your ConfigMap name
updater = ConfigMapUpdater(NAMESPACE, CONFIG_MAP)

@app.post('/')
def index():
    updater.update_configmap();
    return "Hmm, Plus 1 please "


@app.get('/')
def get_counter():
    data = updater.parse_data()
    return str(f"Our counter is: {data.counter} ")


if __name__ == '__main__':
    uvicorn.run(app, port=80, host='0.0.0.0', log_level="debug")
