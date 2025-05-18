#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

echo "clearing out flatpak remotes"
sleep 1
flatpak remote-delete flathub
flatpak remote-delete fedora

echo "adding direct flathub remote"
sleep 1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "flatpak permissions manager/cleaner and other preferred flatpaks"
sleep 1
flatpak install flathub \
com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep \
me.timschneeberger.jdsp4linux io.github.peazip.PeaZip org.gnome.Boxes \
com.valvesoftware.Steam io.github.limo_app.limo \
com.obsproject.Studio org.audacityteam.Audacity org.kde.krita org.kde.kdenlive org.qownnotes.QOwnNotes org.kde.subtitlecomposer \
com.visualstudio.code io.github.shiftey.Desktop \
org.qbittorrent.qBittorrent \
org.upscayl.Upscayl com.github.huluti.Curtail com.github.qarmin.czkawka fr.handbrake.ghb \
com.yacreader.YACReader org.musicbrainz.Picard de.danielnoethen.butt \
com.discordapp.Discord us.zoom.Zoom \
app.ytmdesktop.ytmdesktop io.freetubeapp.FreeTube \
com.github.mtkennerly.ludusavi com.steamgriddb.steam-rom-manager io.itch.itch org.prismlauncher.PrismLauncher uk.co.powdertoy.tpt \
com.feaneron.Boatswain io.github.pwr_solaar.solaar \
org.azahar_emu.Azahar org.flycast.Flycast com.github.AmatCoder.mednaffe org.DolphinEmu.dolphin-emu io.github.simple64.simple64 ca._0ldsk00l.Nestopia org.duckstation.DuckStation net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.ppsspp.PPSSPP info.cemu.Cemu com.snes9x.Snes9x

while
	read -p "install other preferred flatpaks such as libreoffice and celluloid? these are usually preinstalled on distros. (y/N)" moarflatpak
do
	case $moarflatpak in
		([yY][eE][sS] | [yY]) flatpak install flathub org.libreoffice.LibreOffice io.github.celluloid_player.Celluloid;;
		(*) break;;
	esac
done
