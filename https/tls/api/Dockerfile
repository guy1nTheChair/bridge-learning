FROM python:3.8-alpine

COPY . .

RUN pip3 install --no-cache-dir -q -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["flask", "run", "--reload", "--host", "0.0.0.0"]