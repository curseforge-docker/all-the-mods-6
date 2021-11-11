#!/bin/bash
set -euo pipefail

echo -n "Checking for new versions... "

# Download the Versions JSON
VERSIONS_URL=https://addons-ecs.forgesvc.net/api/v2/addon/381671/files
wget -q "${VERSIONS_URL}" -O versions.json

# Get all available versions and save them in the file 'all-versions.txt'
jq -r 'map(.fileName) | .[]' versions.json | rev | cut -d '-' -f 1 | cut -d '.' -f 2-4 | rev | sort >all-versions.txt

# Get all already installed versions and save them in the file 'installed-versions.txt'
ls versions | sort >installed-versions.txt

# Make a list of all versions that are not installed and save it in the file 'needed-versions.txt'
comm -23 all-versions.txt installed-versions.txt >needed-versions.txt

echo "done"

echo "$(wc <needed-versions.txt -l) new version(s) found"

# Go over all needed versions and download the zip files
while read VERSION; do
    echo -n "Downloading version ${VERSION}... "
    FILE_ID=$(jq -r --arg VERSION "$VERSION" 'map(select(.fileName | contains($VERSION + ".zip"))) | map(.serverPackFileId) | .[]' versions.json)
    DOWNLOAD_URL=https://addons-ecs.forgesvc.net/api/v2/addon/381671/file/$FILE_ID/download-url

    # Download the latest modpack zip file
    DOWNLOAD_LINK=$(curl -s "$DOWNLOAD_URL")
    wget -q "$DOWNLOAD_LINK" -O download.zip

    # Unzip the newly downloaded zip file
    unzip -j -qq download.zip -d versions/${VERSION}

    # Remove the downladed zip file and the unwanted bat file
    rm download.zip versions/${VERSION}/startserver.bat

    # Commit the new version
    git add versions/${VERSION}
    git commit --quiet -m "Added new version ${VERSION}"

    echo "done"
done <needed-versions.txt

if (( $(wc <needed-versions.txt -l) > 0)); then
    echo "Pushing new version(s) to git... "

    # Push the new versions
    git push --quiet origin main

    echo "done"
fi

# Remove intermediate files as they are not needed anymore
rm versions.json all-versions.txt installed-versions.txt needed-versions.txt

echo "All done, have fun with the new modpack version(s)"
