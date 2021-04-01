#!/bin/bash
#
# ./bin/build-docker.sh docker_hub organization gitrepo package_name package_version user",


HUB=$1
ORGANIZATION=$2
REPO=$3
PACKAGE=$4
VERSION=$5
USER=$6

# echo "HUB=$HUB"
# echo "ORGANIZATION=$ORGANIZATION"
# echo "REPO=$REPO"
# echo "PACKAGE=$PACKAGE"
# echo "VERSION=$VERSION"

IMAGE_NAME=$HUB/$ORGANIZATION/$REPO/$PACKAGE

echo "IMAGE BUILDER => '$IMAGE_NAME:$VERSION'" 

echo "Logging into $HUB with $USER credentials..." 
cat ../../TOKEN.txt | docker login https://$HUB -u $USER --password-stdin
echo "Done" 

echo "Building and pushing '$VERSION'..." 
docker build -t $IMAGE_NAME:$VERSION .
docker push $IMAGE_NAME:$VERSION
echo "Done" 

echo "Tagging and pushing 'latest'..." 
docker tag $IMAGE_NAME:$VERSION $IMAGE_NAME:latest
docker push $IMAGE_NAME:latest
echo "Done" 

# echo "Updating README for '$IMAGE_NAME'..."
# docker pushrm $HUB/$REPO/$PACKAGE
# echo "Done"
