#!/bin/bash

if [[ ! $EULA == 'true' ]]; then
  echo "You have not yet agreed to the EULA."
  echo "By setting the environment variable \"docker run -e EULA=true\" you are indicating your agreement to the EULA (https://account.mojang.com/documents/minecraft_eula)."
  exit 1
fi

if [ ! -f "eula.txt" ] || ! grep -q "eula=true" eula.txt; then
  echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula)." > eula.txt
  echo "#$(date +'%a %b %d %H:%M:%S %Z %Y')" >> eula.txt
  echo "eula=true" >> eula.txt
fi