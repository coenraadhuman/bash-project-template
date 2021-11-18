#!/usr/bin/env bash

docker image build                                      \
    --build-arg USERNAME=${USER}                        \
    --file "$(pwd)/.builder/install_builder.dockerfile" \
    --tag $(echo "${PWD##*/}" | awk '{print tolower($0)}' | awk '{ gsub(/ /,""); print }'):v1 .
