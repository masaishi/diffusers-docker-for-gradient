#!/bin/bash

IMAGE_NAME="masaishi2001/diffusers-docker-with-jupyter"
TAG=$(date +%s)

# Set up Docker Buildx (Ensure Docker Buildx is installed and set up on your system)
echo "Setting up Docker Buildx..."
docker buildx create --use

# Modify Dockerfile if needed
echo "Modifying Dockerfile..."
./modify_dockerfile.sh

# Build and push Docker image
echo "Building and pushing Docker image..."
docker buildx build . --file Dockerfile --tag "$IMAGE_NAME:$TAG" --push

echo "Docker image $IMAGE_NAME:$TAG has been built and pushed."
