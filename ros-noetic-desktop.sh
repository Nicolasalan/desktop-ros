#!/usr/bin/env bash
set -eu

[[ "$(lsb_release -sc)" == "focal" ]] || exit 1
ROS_DISTRO=noetic

# Install ROS Noetic
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-get install -y curl
curl -k https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
sudo apt-get update || echo ""

sudo apt-get install -y ros-${ROS_DISTRO}-desktop-full
sudo apt-get install -y python3-rosdep

ls /etc/ros/rosdep/sources.list.d/20-default.list > /dev/null 2>&1 && sudo rm /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init 
rosdep update

sudo apt-get install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential python3-vcstool
sudo apt-get install -y python3-catkin-tools python3-osrf-pycommon

# Install Vscode
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt install code

sudo apt-get install -q -y --no-install-recommends 
sudo apt-get install -q -y --no-install-recommends build-essential 
sudo apt-get install -q -y --no-install-recommends apt-utils 
sudo apt-get install -q -y --no-install-recommends cmake 
sudo apt-get install -q -y --no-install-recommends g++ 
sudo apt-get install -q -y --no-install-recommends git 
sudo apt-get install -q -y --no-install-recommends libcanberra-gtk* 
sudo apt-get install -q -y --no-install-recommends python3-catkin-tools 
sudo apt-get install -q -y --no-install-recommends python3-pip 
sudo apt-get install -q -y --no-install-recommends python3-tk 
sudo apt-get install -q -y --no-install-recommends python3-yaml 
sudo apt-get install -q -y --no-install-recommends python3-dev 
sudo apt-get install -q -y --no-install-recommends python3-numpy 
sudo apt-get install -q -y --no-install-recommends python3-rosinstall 
sudo apt-get install -q -y --no-install-recommends python3-catkin-pkg 
sudo apt-get install -q -y --no-install-recommends python3-rosdistro 
sudo apt-get install -q -y --no-install-recommends python3-rospkg 

# Install dependencies ros
sudo apt-get install -y ros-noetic-ros-controllers 
sudo apt-get install -y ros-noetic-joint-state-controller 
sudo apt-get install -y ros-noetic-joint-state-publisher 
sudo apt-get install -y ros-noetic-robot-state-publisher 
sudo apt-get install -y ros-noetic-robot-state-controller 
sudo apt-get install -y ros-noetic-xacro 
sudo apt-get install -y ros-noetic-smach-ros 
sudo apt-get install -y ros-noetic-gazebo-ros 
sudo apt-get install -y ros-noetic-gazebo-ros-control 
sudo apt-get install -y ros-noetic-rplidar-ros 
sudo apt-get install -y ros-noetic-driver-base 
sudo apt-get install -y ros-noetic-rosserial-arduino

# Setup Env
grep -F "source /opt/ros/${ROS_DISTRO}/setup.bash" ~/.bashrc ||
echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

grep -F `catkin locate --shell-verbs` ~/.bashrc ||
echo "source `catkin locate --shell-verbs`" >> ~/.bashrc

grep -F "ROS_IP" ~/.bashrc ||
echo "export ROS_IP=127.0.0.1" >> ~/.bashrc

grep -F "ROS_MASTER_URI" ~/.bashrc ||
echo "export ROS_MASTER_URI=http://\$ROS_IP:11311" >> ~/.bashrc