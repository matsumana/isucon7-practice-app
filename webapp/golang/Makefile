ME := sgykfjsm  # Set your name here

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

upload:
	cp -pvf ./bin/app-linux-amd64 ./app
	./awstool s3upload --object ./app --user $(ME)
	$(RM) ./app

clean:
	$(RM) -v -r bin ./app

setup:
	go get -u .
