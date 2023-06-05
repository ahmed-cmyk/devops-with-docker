# Exercise 3.4

## Steps

1. Run the command `docker build -t builder .`
2. Then download and push an image using the `docker run -v /var/run/docker.sock:/var/run/docker.sock builder <DOCKER_USER> <DOCKER_PASSWORD> <GITHUB_REPO> <DOCKER_REPO>`

The Github repo should be in the format: <USERNAME>/<REPOSITORY>
The Docker repo should be in the format: <USERNAME>/<IMAGE_NAME>

For example:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock builder mluukkai password_here mluukkai/express_app mluukkai/testing2
```

---

## Files

Dockerfile:

```
FROM node:20

RUN apt-get update && apt-get install -y git && apt-get install -y docker.io

COPY ./builder.sh .
COPY ./docker_password.txt .

ENTRYPOINT ["./builder.sh"]
```

builder.sh:

```
#!/bin/bash

if [ ! -f "./docker_password.txt" ]; then
    echo "please include the docker_password.txt in the current directory"
    exit 0
fi

rm -rf repo_files

username=$1
password=$2

github_repo=https://github.com/${3}.git
docker_repo=$4

git clone $github_repo repo_files
if [ $? != 0 ]; then
    echo "Please recheck github repo"
    exit 0
fi

docker login --username $username --password $password
if [ $? != 0 ]; then
    echo "Username or password is incorrect"
    exit 0
fi

cd repo_files

docker build . -t $docker_repo
docker push $docker_repo
```

---
