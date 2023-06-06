# Exercise 3.7

## Size Changes

Frontend: 1.2GB -> 468.54MB
Backend: 822MB -> 482.17MB

---

## Dockerfiles

Frontend Dockerfile:

```
FROM node:16.20-alpine3.18

WORKDIR /frontend

ENV LC_ALL=C.UTF-8
ENV REACT_APP_BACKEND_URL=http://localhost:8080

COPY . .

RUN npm install && \
    npm run build && \
    npm install -g serve && \
    adduser -D appuser && \
    chown appuser .

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
```

Backend Dockerfile:

```
FROM golang:alpine3.18

WORKDIR /backend

ENV LC_ALL=C.UTF-8
ENV REQUEST_ORIGIN=http://localhost:5000

COPY . .

RUN apk add --no-cache ca-certificates && \
    go build && \
    adduser -D appuser && \
    chown appuser .

USER appuser

CMD ./server
```
