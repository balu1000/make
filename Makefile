VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

.PHONY: linux linux/arm macos macos/arm windows windows/arm clean

format:
	gofmt -s -w ./

vet:
	go vet

test:
	go test -v	
	
get:
	go get

linux: format get
		CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION}

linux/arm: format get
		CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION}

windows: format get
		CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION}

windows/arm: format get
		CGO_ENABLED=0 GOOS=windows GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION}

macos: format get
		CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION}

macos/arm: format get
		CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/balu1000/kbot.git/cmd.appVersion=${VERSION}

clean:
	rm -rf kbot