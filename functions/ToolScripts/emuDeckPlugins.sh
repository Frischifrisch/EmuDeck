#!/bin/bash

Plugins_installPluginLoader(){
   local PluginLoader_releaseURL="https://github.com/SteamDeckHomebrew/PluginLoader/raw/main/dist/install_release.sh"
   mkdir -p "$HOME/homebrew"
   sudo chown -R deck:deck "$HOME/homebrew"
   curl -L $PluginLoader_releaseURL | sh
   touch "$HOME/.steam/steam/.cef-enable-remote-debugging"
   sudo systemctl disable --now steam-web-debug-portforward.service
}

Plugins_installPowerTools(){
   local ptHash
   ptHash=$(curl https://beta.deckbrew.xyz/plugins | jq -r '.[] | select(.name=="PowerTools").versions[0].hash')
   local url="https://cdn.tzatzikiweeb.moe/file/steam-deck-homebrew/versions/$ptHash.zip"
   sudo rm -rf "$HOME/homebrew/plugins/PowerTools"
   curl -l "$url" --output "$HOME/homebrew/PowerTools.zip.temp"  && mv "$HOME/homebrew/PowerTools.zip.temp" "$HOME/homebrew/PowerTools.zip" 
   sudo unzip "$HOME/homebrew/PowerTools.zip" -d "$HOME/homebrew/plugins/" && rm "$HOME/homebrew/PowerTools.zip"
}

Plugins_installDeckyControls(){
   local destinationFolder="$HOME/homebrew/plugins/emudeck-decky-controls"
   local DeckyControls_releaseURL="$(getLatestReleaseURLGH "EmuDeck/emudeck-decky-controls" ".zip")"
   sudo rm -rf $destinationFolder
   sudo mkdir -p $destinationFolder
   sudo curl -L "$DeckyControls_releaseURL" -o "${destinationFolder}/emudeck-decky-controls.zip"
   sudo unzip "$destinationFolder/emudeck-decky-controls.zip" -d "$destinationFolder" && sudo rm "$destinationFolder/emudeck-decky-controls.zip"
   sudo chown deck:deck -R $HOME/homebrew/plugins/emudeck-decky-controls
   chmod 555 -R $HOME/homebrew/plugins/emudeck-decky-controls
}

Plugins_installSteamDeckGyroDSU(){
   InstallGyro=$(bash <(curl -sL https://github.com/kmicki/SteamDeckGyroDSU/raw/master/pkg/update.sh))
	printf '%s' "$InstallGyro"
}


