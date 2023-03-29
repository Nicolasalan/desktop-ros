# Desktop ROS Noetic

<p align="center">
  <a href="http://wiki.ros.org/noetic">
    <img src="https://img.shields.io/badge/ROS-Noetic-yellow" alt="ROS Noetic Compatible">
  </a>
  <a href="https://docs.docker.com/">
    <img src="https://img.shields.io/badge/Docker-v20.10.21-blue" alt="Docker">
  </a>
  <a href="https://releases.ubuntu.com/">
    <img src="https://img.shields.io/badge/Ubuntu-v20.04-9cf" alt="Ubuntu">
</p>

### Start Desktop

```bash
cd desktop-ros
chmod 777 *
docker build -t desktop-docker 
docker run -p 6080:80 --shm-size=512m desktop-docker # Browse http://localhost:6080/
```



