from flask import Flask, request, Response
import json
import requests
import os

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/chart')
def chart():
    api_key = os.getenv('open_ai_key')
    headers = {'Authorization': 'Bearer ' + api_key}
    data = {"model": "gpt-3.5-turbo","messages": [{"role": "user", "content": request.args.get('input')}]}
    res = requests.post("https://api.openai.com/v1/chat/completions", json=data, headers=headers)
    return Response(res,  mimetype='application/json')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
