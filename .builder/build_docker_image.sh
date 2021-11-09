#!/usr/bin/env bash

time docker image build                 \
    --build-arg USERNAME=${USER}        \
    --file ${PWD}/.builder/install_builder.dockerfile \
    --tag $(echo "${PWD##*/}"):v1 .
