# Exercise 3.8

## Dockerfile

```
FROM node:16 as build-stage
WORKDIR /frontend

COPY . .

RUN npm install && \
    npm run build

FROM node:16.20-alpine3.18

ENV LC_ALL=C.UTF-8

COPY --from=build-stage /frontend /usr/app/frontend

RUN adduser -D appuser && \
    chown appuser . && \
    npm install -g serve

USER appuser

CMD ["serve", "-s", "-l", "5000", "build"]
```

---

## Size

1.21GB -> 312.34MB

---
