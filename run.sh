#!/bin/bash

rm -rf ./release
mkdir -p ./release

odin build ./source/demo_main \
    -collection:source=./source \
    -out:./release/main \
    -o:speed

exec ./release/main
