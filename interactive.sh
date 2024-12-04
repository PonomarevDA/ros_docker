#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS_DIR="${SCRIPT_DIR}/models"
IMAGE_NAME=ros_docker

xhost +local:docker  # Allow local docker containers to connect to the X server

docker container run \
    -it \
    --rm \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --device=/dev/dri \
    --volume="${SCRIPT_DIR}/example_package:/catkin_ws/src/example_package:rw" \
    ros_docker \
    /bin/bash
