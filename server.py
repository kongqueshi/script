from flask import Flask, request
import requests

OPEN_AI_KEY = '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'

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/chart')
def chart():
    headers = {'Authorization': 'Bearer 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'}
    data = {"model": "gpt-3.5-turbo","messages": [{"role": "user", "content": request.args.get('input')}]}
    res = requests.post("https://api.openai.com/v1/chat/completions", json=data, headers=headers)
    print(res.json())
    return res.json()['choices'][0]['message']['content']


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)
