version: "3.9"

services:
    web-logger:
        image: devopsdockeruh/simple-web-service
        build: .
        volumes: 
            - ./log:/usr/src/app/text.log
        container_name: web-logger
