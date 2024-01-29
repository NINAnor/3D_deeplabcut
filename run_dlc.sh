#!/bin/bash

docker run \
    --gpus all \
    --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=$DISPLAY \
    -it \
    --entrypoint "" \
    -v $PWD:/host deeplabcut/deeplabcut:2.3.5-base-cuda11.7.1-cudnn8-runtime-ubuntu20.04-latest \
    bash

