FROM node:20

RUN apt-get update && apt-get install -y git && apt-get install -y docker.io

COPY ./builder.sh .
COPY ./docker_password.txt .

ENTRYPOINT ["./builder.sh"]