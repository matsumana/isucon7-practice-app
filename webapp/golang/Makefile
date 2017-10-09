init:
	go get -u github.com/golang/dep/cmd/dep
	dep init

deps:
	dep ensure
	dep ensure --update

all:
	go build -o app

build:
	./build.sh

setup:
	go get -u .
