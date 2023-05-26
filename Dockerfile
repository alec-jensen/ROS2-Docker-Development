FROM osrf/ros:humble-desktop 

ARG DEBIAN_FRONTEND=noninteractive

SHELL [ "/bin/bash", "-c" ]

# use a closer mirror in dallas, texas
RUN cp /etc/apt/sources.list /etc/apt/sources.list.original && \
    sed -i -r 's,http://(.*).ubuntu.com,http://mirror.us-tx.kamatera.com,' /etc/apt/sources.list

# install basic dependnecies
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
    wget

# install velodyne dependencies
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
    ros-humble-velodyne

# install intel dependencies
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
    ros-humble-librealsense2* \
    ros-humble-realsense2-*

# create workspace folder and make it the starting folder
RUN mkdir -p /root/colcon_workspace && \
    echo "cd /root/colcon_workspace" >> /root/.bashrc

# source ROS setup.bash
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc