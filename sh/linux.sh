#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

echo "checking distro"
sleep 1
# cat /etc/*release
# condition to check what distro you're using here

# flatpak and curl cmd is generic so that won't matter
# this is just for updating/upgrading

echo "before anything... updating and upgrading"
sleep 1
apt update -y
apt upgrade -y

echo "adding flathub, distrobox/boxbuddy and preferred flatpaks"
sleep 1
installThings() {
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
	com.feaneron.Boatswain org.kde.kdenlive io.freetubeapp.FreeTube com.discordapp.Discord org.qbittorrent.qBittorrent io.github.celluloid_player.Celluloid org.audacityteam.Audacity org.kde.krita io.github.shiftey.Desktop org.libreoffice.LibreOffice io.github.pwr_solaar.solaar org.upscayl.Upscayl com.spotify.Client io.github.peazip.PeaZip com.obsproject.Studio us.zoom.Zoom me.timschneeberger.jdsp4linux com.vscodium.codium \
	com.valvesoftware.Steam com.steamgriddb.steam-rom-manager com.mojang.Minecraft uk.co.powdertoy.tpt io.itch.itch net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2 org.flycast.Flycast \
	io.github.limo_app.limo \
	io.github.zen_browser.zen
}
if ! installThings; then
	exit 1
fi