# This software is distributed under the terms of the GPL v3 License.
# Copyright (c) 2021-2024 Dmitry Ponomarev.
# Author: Dmitry Ponomarev <ponomarevda96@gmail.com>

# Use the official ROS Noetic image as a base
ARG ROS_DISTRO=noetic
FROM ros:$ROS_DISTRO

# Set up the environment
SHELL ["/bin/bash", "-c"]
ENV DISPLAY=:0

# Install necessary dependencies
COPY scripts/install.sh scripts/install.sh
RUN scripts/install.sh --yes && rm -rf /var/lib/apt/lists/*

WORKDIR /catkin_ws/src/example_package
