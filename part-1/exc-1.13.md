FROM golang:1.16-stretch

EXPOSE 8080

WORKDIR /usr/src/app

COPY . .

RUN go build

CMD ./server
