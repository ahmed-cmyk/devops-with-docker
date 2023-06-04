Repository: https://github.com/ahmed-cmyk/nodejs-docker-actions

Compose File:

```
version: '3.9'

services:
  node-app:
    image: ikramahmed398/express-app-example
    container_name: node-app
    labels:
      - 'com.centurylinklabs.watchtower.enable=true'
    ports:
      - 8080:8080
  watchtower:
    image: containrrr/watchtower:1.5.3
    container_name: watchtower
    environment:
      - WATCHTOWER_POLL_INTERVAL=60
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

deploy.yml:

```
name: Release NodeJS App

on:
  push:
    branches:
      - main

jobs:
  publish-docker-hub:
    name: Publish image to docker hub
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v4
        with:
          file: ./Dockerfile
          push: true
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/express-app-example:latest
```
