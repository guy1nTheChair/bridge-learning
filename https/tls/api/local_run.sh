source ./env/bin/activate
pip3 install -q -r requirements.txt
export FLASK_APP=app.py
export FLASK_ENV=dev
flask run --reload