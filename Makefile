all: test-run

GO_VER = 1.24
IMAGE_NAME = go$(GO_VER)-integration
IMAGE_VER = v1.5.1
CONTAINER_NAME = go$(GO_VER)-integration
MAPPING_SSH_PORT = 30002
DOCKERFILE_PATH = $(PWD)/Dockerfile
DOCKER_BUILD_DIR = $(PWD)
SLEEP_SECS=2

test-run:
	echo "test"   

docker-build:
	sudo docker build -f $(DOCKERFILE_PATH) -t $(IMAGE_NAME):$(IMAGE_VER) $(DOCKER_BUILD_DIR)

docker-ps:
	sudo docker ps -f name=$(CONTAINER_NAME)

docker-run:
	sudo docker run -d -p $(MAPPING_SSH_PORT):22 --privileged=true -v /home/wh/project/go_project_mapping:/home/op1/go_project_mapping -v /home/wh/project/go_project_local:/home/op1/go_project_local --name $(CONTAINER_NAME) $(IMAGE_NAME):$(IMAGE_VER)
	sleep $(SLEEP_SECS)
	sudo docker ps -f name=$(CONTAINER_NAME)
	sudo docker logs $(CONTAINER_NAME)

docker-start:
	sudo docker start $(CONTAINER_NAME)
	sleep $(SLEEP_SECS)
	sudo docker ps -f name=$(CONTAINER_NAME)

docker-stop:
	sudo docker stop $(CONTAINER_NAME)

docker-rm:
	sudo docker stop $(CONTAINER_NAME)
	sudo docker rm $(CONTAINER_NAME)

docker-rmi-repo:
	sudo docker rmi $(IMAGE_NAME)

docker-rmi-repo-tag:
	sudo docker rmi $(IMAGE_NAME):$(IMAGE_VER)

build-daemon-app:
	go version
	go build -o $(BUILD_DAEMONAPP_OUTPUT_PATH) $(DAEMONAPP_PATH)/main.go



.PHONY: docker-build docker-ps docker-run docker-start docker-stop docker-rm docker-rmi-repo docker-rmi-repo-tag build-daemon-app
