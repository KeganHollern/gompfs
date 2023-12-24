.PHONY: linux
linux:
	docker build -t linux .
	docker run -d --name temp linux
	docker cp temp:/app/gompfs ./gompfs-linux
	docker stop temp
	docker rm temp

.PHONY: build
build:
	CGO_ENABLED=1 \
	GOARCH=arm64 \
	GOOS=linux \
	CGO_CFLAGS="-DLINUX -I${PWD}/includes" \
	CGO_LDFLAGS="-L${PWD}/libs ${PWD}/libs/vmm.so ${PWD}/libs/leechcore.so" \
	go build -o gompfs -x