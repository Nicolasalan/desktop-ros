DOCKER_VOLUMES = \
 	--volume="/tmp/.X11-unix:/tmp/.X11-unix" \
 	--volume="${HOME}/.Xauthority:/root/.Xauthority:rw" \
 	--volume="/dev:/dev" 
	
DOCKER_ENV_VARS = \
	--env="DISPLAY=${DISPLAY}" \
 	--env="QT_X11_NO_MITSHM=1" \
 	--ipc=host \
 	--privileged 

define xhost_activate
	@echo "Enabling local xhost sharing:"
	@echo "  Display: ${DISPLAY}"
	@xhost local:root
endef

.PHONY: terminal
terminal:
	@echo "Terminal Arm64 docker ..."
	@sudo xhost + 
	@docker run --platform=linux/arm64/v8 -it --net=host ${DOCKER_ARGS} humble bash
