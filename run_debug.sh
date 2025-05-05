#!/bin/bash

rm -rf ./debug
mkdir -p ./debug

odin build ./source/demo_main \
    -collection:source=./source \
    -out:./debug/main \
    -debug

exec ./debug/main
