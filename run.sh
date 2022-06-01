#!/bin/bash

# docker build -t tools .
# docker tag tools:latest star3am/repository:tools
# docker login
# docker push star3am/repository:tools

pwd
docker images | grep tools
docker buildx create --name tools --use
docker buildx inspect
# https://vikaspogu.dev/posts/docker-buildx-setup/
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx build --platform=linux/amd64,linux/arm64 -t tools:latest .
docker buildx imagetools inspect star3am/repository:tools
docker compose run --rm tools bash -c '
  python -V
  pip -V
  cookiecutter --version
  aws --version
  az --version
  gcloud --version
  dbt --version
  kubectl version
  terraform -version
  terragrunt -version
  pwd
'

