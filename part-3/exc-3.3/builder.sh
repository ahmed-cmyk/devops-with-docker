#!/bin/bash

if [ ! -f "./docker_password.txt" ]; then
    echo "please include the docker_password.txt in the current directory"
    exit 0
fi

rm -rf repo_files

github_repo=https://github.com/${1}.git
docker_repo=$2
password=$(<docker_password.txt)

echo "What is your username?"
read username

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
