wget https://raw.githubusercontent.com/kongqueshi/script/main/server.py
pip install flask
pip install flask-cors
nohup python3 ./server.py > server.log &
