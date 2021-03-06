#!/bin/bash

# Program name
PROGNAME=$(basename "$0")

# Error trapping
error_exit() {
  echo "${PROGNAME}: ${1:-"Error"}" 1>&2
  exit 1
}

image_name="sbubmi/pathomics_analysis:1.0.0rc0"
container_name="$USER-pathomics_analysis"

# Build image from dockerfile
echo ""
echo "BUILDING DOCKER IMAGE"
echo ""
cd ../..
docker build -t "$image_name" . || error_exit "Could not build container."

# Or:
# docker pull $image_name

echo "Quick nap... 3 2 1"
sleep 3

# Start container
echo ""
echo "STARTING CONTAINER"
echo ""
python nucleusSegmentation/script/run_docker_segment.py start $container_name $image_name
