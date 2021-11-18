#!/usr/bin/env bash

set -euo pipefail

sh ./.docker/build_runner_image.sh

if [[ $? -eq 0 ]]; then
  docker container run                         \
  --volume "$(pwd)/target:/scripts/target"     \
  --user $(id -u ${USER}):$(id -g ${USER})     \
  --rm -it --name $(echo "${PWD##*/}" | awk '{print tolower($0)}' | awk '{ gsub(/ /,""); print }') \
  $(echo "${PWD##*/}" | awk '{print tolower($0)}' | awk '{ gsub(/ /,""); print }'):runner
fi 