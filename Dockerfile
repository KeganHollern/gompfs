# Start from a base image that includes Go and necessary cross-compiling tools
FROM golang:latest

# Set the target OS and architecture for cross-compilation
ENV GOOS=linux
ENV GOARCH=arm64
ENV CGO_ENABLED=1

# Install the cross-compiler and other necessary tools for ARM64
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc-aarch64-linux-gnu \
    libc6-dev-arm64-cross \
    pkg-config libusb-1.0 libusb-1.0-0-dev libfuse2 libfuse-dev libpython3-dev lz4 liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the cross-compiler as the default C compiler for CGO
ENV CC=aarch64-linux-gnu-gcc

# Create a working directory
WORKDIR /app

# Copy the Go source files into the container
COPY . .

# Build the application
RUN make build

# This results in a binary named 'gompfs' inside the container in the /app directory
# which is built for Linux ARM64
CMD tail -f /dev/null