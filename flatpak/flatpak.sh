#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

# flatpak and curl cmd is generic so that won't matter
echo "adding direct flathub remote"
sleep 1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "generic curl install for distrobox"
sleep 1
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

echo "flatpak permissions and cleaner, distrobox gui and other preferred flatpaks"
sleep 1
flatpak install flathub \
com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep io.github.dvlv.boxbuddyrs \
org.mozilla.firefox dev.qwery.AddWater \
com.valvesoftware.Steam io.github.Foldex.AdwSteamGtk com.steamgriddb.steam-rom-manager io.github.limo_app.limo \
 com.github.mtkennerly.ludusavi net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2 org.flycast.Flycast io.github.simple64.simple64 info.cemu.Cemu com.snes9x.Snes9x net.minetest.Minetest uk.co.powdertoy.tpt \
org.kde.subtitlecomposer org.upscayl.Upscayl io.github.pwr_solaar.solaar com.yacreader.YACReader org.libreoffice.LibreOffice fr.handbrake.ghb org.musicbrainz.Picard com.obsproject.Studio com.discordapp.Discord org.kde.kdenlive app.ytmdesktop.ytmdesktop org.audacityteam.Audacity org.kde.krita com.visualstudio.code io.github.shiftey.Desktop org.qbittorrent.qBittorrent io.github.celluloid_player.Celluloid io.freetubeapp.FreeTube io.github.peazip.PeaZip org.gnome.Boxes com.github.huluti.Curtail me.timschneeberger.jdsp4linux com.feaneron.Boatswain us.zoom.Zoom