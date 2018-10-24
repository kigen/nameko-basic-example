TAG ?= dev

# docker
build-image:
	docker build -t nameko/basic-example:$(TAG) .;
	docker-compose up;