#!flask/bin/python
from flask import Flask, request, request_started
import os.path
from os import path

app = Flask(__name__)
counter = 0
counter_file = "counter/counter.txt"
@app.route('/', methods=["POST", "GET"])
def index():
    global counter
    if request.method == "POST":
        counter+=1
        if (path.exists(counter_file)):
            file1 = open(counter_file, 'w')
            file1.write(str(counter))
            file1.close()
        return "Hmm, Plus 1 please "
    else:
        return str(f"Our counter is: {counter} ")
if __name__ == '__main__':
    if (path.exists(counter_file)):
        file1 = open(counter_file, 'r')
        Line = file1.readline()
        counter=int(Line)
        file1.close()
    app.run(debug=True,port=80,host='0.0.0.0')
