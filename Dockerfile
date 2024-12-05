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

# Add sources to .bashrc
RUN echo 'echo "This is a ROS Docker Container."' >> ~/.bashrc && \
    echo 'source /opt/ros/noetic/setup.bash' >> ~/.bashrc && \
    echo 'source /catkin_ws/devel/setup.bash' >> ~/.bashrc

# Create an example package and build catkin workspace
WORKDIR /catkin_ws/src/example_package
RUN cd /catkin_ws && catkin init
COPY example_package/CMakeLists.txt /catkin_ws/src/example_package/CMakeLists.txt
COPY example_package/package.xml /catkin_ws/src/example_package/package.xml
RUN source /opt/ros/noetic/setup.bash && cd /catkin_ws && catkin build

RUN sudo apt-get update && sudo apt-get install -y ros-noetic-mavros
RUN sudo apt-get update && sudo apt-get install -y ros-noetic-mavros-extras
RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && sudo bash install_geographiclib_datasets.sh
