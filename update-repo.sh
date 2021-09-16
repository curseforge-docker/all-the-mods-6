# Download the Versions JSON
VERSIONS_URL=https://addons-ecs.forgesvc.net/api/v2/addon/381671/files
wget "${VERSIONS_URL}" -O versions.json

# Set the env variable LATEST_VERSION_NUMBER
LATEST_VERSION_NUMBER=$(jq -r 'sort_by(.fileDate)[-1].fileName' versions.json | cut -d '-' -f 2 | cut -d '.' -f 1-3)
echo $LATEST_VERSION_NUMBER

# Set the env variable LATEST_VERSION_DOWNLOAD
LATEST_VERSION_DOWNLOAD=https://www.curseforge.com/minecraft/modpacks/all-the-mods-6/download/$(jq -r 'sort_by(.fileDate)[-1].serverPackFileId' versions.json)/file
echo $LATEST_VERSION_DOWNLOAD

# Remove the downladed versions JSON
rm versions.json

# Download the latest versions zip file
wget "$LATEST_VERSION_DOWNLOAD" -O download.zip

# Create new Folder for the new version
#mkdir versions/${LATEST_VERSION_NUMBER}

# Unzip the newly downloaded File
#unzip download.zip -d versions/${LATEST_VERSION_NUMBER}

# Remove the downladed versions zip file
#rm download.zip

# Remove the unwanted bat file
#rm versions/${LATEST_VERSION_NUMBER}/startserver.bat

# Commit and Push the new Version
#git add versions/${LATEST_VERSION_NUMBER}
#git commit -m "New Version: ${LATEST_VERSION_NUMBER}"
#git push origin main
