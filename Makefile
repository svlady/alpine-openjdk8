REPO ?= svlady
NAME = $(REPO)/alpine-openjdk8

JAVA_VERSION ?= 8u191
PKG_VERSION  ?= 8.191.12-r0

TAG = $(PKG_VERSION)

build:
	docker build --build-arg JAVA_VERSION=$(JAVA_VERSION) --build-arg JAVA_ALPINE_VERSION=$(PKG_VERSION) -t $(NAME) .
	docker tag $(NAME) $(NAME):$(TAG)

release: build
	docker push $(NAME):$(TAG)

run: build
	docker run -ti --rm --net=host $(NAME):$(TAG)

shell:
	docker run -ti --rm --net=host --entrypoint=/bin/sh $(NAME):$(TAG)
