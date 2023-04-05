FROM dorowu/ubuntu-desktop-lxde-vnc:focal

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN apt-get update -q && \
    apt-get upgrade -yq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq wget curl git build-essential vim sudo lsb-release locales bash-completion tzdata gosu && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --home-dir /home/ubuntu --shell /bin/bash --user-group --groups adm,sudo ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN sudo apt-get install -y curl
RUN curl -k https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
RUN sudo apt-get update

RUN sudo apt-get install -y ros-noetic-desktop-full
RUN sudo apt-get install -y python3-rosdep

RUN sudo rosdep init 
RUN rosdep update

# Install dependencies
RUN apt-get install -q -y --no-install-recommends \
  build-essential \
  apt-utils \
  cmake \
  g++ \
  git \
  libcanberra-gtk* \
  python3-pip \
  python3-tk \
  python3-yaml \
  python3-dev \
  python3-numpy \
  python3-rosinstall \
  python3-catkin-pkg \
  python3-rosdistro \
  python3-rospkg \
  python3-rosinstall-generator \
  python3-wstool \ 
  python3-vcstool \ 
  python3-osrf-pycommon 

# Install dependencies ros
RUN apt-get update && apt-get install -y ros-noetic-ros-controllers \
 && apt-get install -y ros-noetic-joint-state-controller \
 && apt-get install -y ros-noetic-joint-state-publisher \
 && apt-get install -y ros-noetic-robot-state-publisher \
 && apt-get install -y ros-noetic-robot-state-controller \
 && apt-get install -y ros-noetic-xacro \ 
 && apt-get install -y ros-noetic-smach-ros \
 && apt-get install -y ros-noetic-gazebo-ros \
 && apt-get install -y ros-noetic-gazebo-ros-control \
 && apt-get install -y ros-noetic-rplidar-ros \
 && apt-get install -y ros-noetic-driver-base \
 && apt-get install -y ros-noetic-rosserial-arduino 

# Setup Env
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

#RUN sudo catkin locate --shell-verbs 
RUN echo "$(catkin locate --shell-verbs)" >> ~/.bashrc
RUN grep -F "$(catkin locate --shell-verbs)" ~/.bashrc

RUN echo "export ROS_IP=127.0.0.1" >> ~/.bashrc
RUN grep -F "ROS_IP" ~/.bashrc

RUN echo "export ROS_MASTER_URI=http://127.0.0.1:11311" >> ~/.bashrc
RUN grep -F "ROS_MASTER_URI" ~/.bashrc

COPY ./workspace /home/ubuntu
#VOLUME /dev /dev

RUN rm -rf /var/lib/apt/lists/*

ENV USER ubuntu