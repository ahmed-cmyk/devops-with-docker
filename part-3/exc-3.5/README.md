# Exercise 3.5

Frontend Dockerfile:

```
FROM node:16

WORKDIR /frontend

EXPOSE 5000

ENV REACT_APP_BACKEND_URL=http://localhost:8080

COPY . .

RUN npm install
RUN npm run build
RUN npm install -g serve
RUN useradd -m appuser
RUN chown appuser .

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
```

Backend Dockerfile:

```
FROM golang:1.16-stretch

EXPOSE 8080

ENV REQUEST_ORIGIN=http://localhost:5000

WORKDIR /backend

COPY . .

RUN go build
RUN useradd -m appuser
RUN chown appuser .

USER appuser

CMD ./server
```
