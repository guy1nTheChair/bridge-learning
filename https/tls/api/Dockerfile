FROM python:3.8-alpine

COPY app.py .
COPY requirements.txt .

RUN pip3 install -q -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["flask", "run", "--reload", "--host", "0.0.0.0"]