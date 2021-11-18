#!/usr/bin/env bash

docker image build                                      \
    --build-arg USERNAME=${USER}                        \
    --file "$(pwd)/.docker/install_runner.dockerfile" \
    --tag $(echo "${PWD##*/}" | awk '{print tolower($0)}' | awk '{ gsub(/ /,""); print }'):runner .
