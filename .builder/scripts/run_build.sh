#!/usr/bin/env bash

cd /workdir

if [[ $? -eq 0 ]]; then
	make
fi
