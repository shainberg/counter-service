#!flask/bin/python
import uvicorn
from fastapi import FastAPI

app = FastAPI()
counter = 0


@app.post('/')
def index():
    global counter
    counter += 1
    return "Hmm, Plus 1 please "


@app.get('/')
def get_counter():
    global counter
    return str(f"Our counter is: {counter} ")


if __name__ == '__main__':
    uvicorn.run(app, port=80, host='0.0.0.0', log_level="debug")
