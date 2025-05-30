#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

echo "Clearing out flatpak remotes."
sleep 1
flatpak remote-delete flathub
flatpak remote-delete fedora

echo "Adding direct Flathub remote."
sleep 1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# leaving the apps to flathub and the desktop/browser to the pkg manager
echo "Permissions manager/cleaner and other preferred flatpaks"
sleep 1
flatpak install flathub \
com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep \
me.timschneeberger.jdsp4linux io.github.peazip.PeaZip org.gnome.Boxes \
com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive org.qownnotes.QOwnNotes org.kde.subtitlecomposer \
com.visualstudio.code io.github.shiftey.Desktop \
org.qbittorrent.qBittorrent \
org.upscayl.Upscayl com.github.huluti.Curtail com.github.qarmin.czkawka fr.handbrake.ghb \
com.yacreader.YACReader org.musicbrainz.Picard \
com.discordapp.Discord us.zoom.Zoom \
app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube \
com.feaneron.Boatswain io.github.pwr_solaar.solaar

while
	read -p "Install other preferred flatpaks such as LibreOffice and MPV-based Celluloid? These are usually preinstalled on distros. (y/N)" etc
do
	case $etc in
		([yY][eE][sS] | [yY]) flatpak install flathub org.libreoffice.LibreOffice io.github.celluloid_player.Celluloid;;
		(*) break;;
	esac
done

while
	read -p "Install various gaming apps? (y/N)" gaming
do
	case $gaming in
		([yY][eE][sS] | [yY]) flatpak install flathub com.valvesoftware.Steam io.itch.itch com.github.mtkennerly.ludusavi io.github.limo_app.limo \ org.prismlauncher.PrismLauncher uk.co.powdertoy.tpt \ com.steamgriddb.steam-rom-manager org.azahar_emu.Azahar org.flycast.Flycast com.github.AmatCoder.mednaffe org.DolphinEmu.dolphin-emu io.github.simple64.simple64 ca._0ldsk00l.Nestopia org.duckstation.DuckStation net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.ppsspp.PPSSPP info.cemu.Cemu com.snes9x.Snes9x;;
		(*) break;;
	esac
done