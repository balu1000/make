TAG_LINUX := linux/amd64
TAG_LINUX-ARM := linux/arm64
TAG_MACOS := macos/amd64
TAG_WINDOWS := windows/amd64

VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

#.PHONY: linux linux/arm macos macos/arm windows windows/arm clean

format:
	gofmt -s -w ./

vet:
	go vet

test:
	go test -v	
	
get:
	go get

linux: format get
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o linux/amd64 -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION} .
    docker build -t $(TAG_LINUX) .

linux/arm:
    CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o linux/arm64 -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION} .
    docker build -t $(TAG_LINUX-ARM) .

clean:
    docker rmi $(TAG_LINUX) $(TAG_LINUX-ARM) $(TAG_MACOS) $(TAG_WINDOWS) $(TAG_MACOS-ARM) $(TAG_WINDOWS-ARM)