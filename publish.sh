#!/bin/bash
set -euo pipefail

# Variables
DOCKER_HUB_TAGS_URL=https://registry.hub.docker.com/v1/repositories/curseforge/all-the-mods-6/tags
MODPACK_NAME=all-the-mods-6
JAVA_VERSION=8

echo -n "Checking for unpublished versions... "

# Get all already published versions from docker hub
wget -q "${DOCKER_HUB_TAGS_URL}" -O versions.json

# Save the published versions in the file 'published-versions.txt'
jq -r '.[].name' versions.json | grep -v -x -F latest | sort >published-versions.txt

# Get all local versions and save them in the file 'local-versions.txt'
ls versions | sort >local-versions.txt

# Make a list of all versions that are not installed and save it in the file 'unpublished-versions.txt'
comm -23 local-versions.txt published-versions.txt >unpublished-versions.txt

echo "done"

echo " => $(wc <unpublished-versions.txt -l) unpublished version(s) found"

# Go over all unpublished versions and publish them to Docker Hub and GitHub Container Registry
while read VERSION; do
    echo -n "Building docker image for ${VERSION}... "

    # Build docker image
    docker build . \
        -q \
        -t curseforge/${MODPACK_NAME}:${VERSION} \
        -t curseforge/${MODPACK_NAME}:latest \
        -t ghcr.io/curseforge-docker/${MODPACK_NAME}:${VERSION} \
        -t ghcr.io/curseforge-docker/${MODPACK_NAME}:latest \
        --build-arg VERSION=${VERSION} \
        --build-arg JAVA_VERSION=${JAVA_VERSION}

    echo "done"

    echo -n "Pushing version ${VERSION} to Docker Hub... "

    # Push to Docker Hub
    docker push -q curseforge/${MODPACK_NAME}:${VERSION}
    docker push -q curseforge/${MODPACK_NAME}:latest

    echo "done"

    echo -n "Pushing version ${VERSION} to GitHub Container Registry... "

    # Push to GitHub Container Registry
    docker push -q ghcr.io/curseforge-docker/${MODPACK_NAME}:${VERSION}
    docker push -q ghcr.io/curseforge-docker/${MODPACK_NAME}:latest

    echo "done"
done <unpublished-versions.txt

# Remove intermediate files as they are not needed anymore
rm versions.json published-versions.txt local-versions.txt unpublished-versions.txt

echo "All done, have fun with the published docker image(s)"
