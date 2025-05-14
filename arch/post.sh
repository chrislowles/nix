#!/bin/bash

# post-install script

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

if [ ! -f "/etc/arch-release" ]; then
	# arch only
	echo "This script is only intended to run on Arch Linux"
	exit 1
fi

# install depending on base distro (debian, arch)
# steam-devices

echo "Adding direct Flathub remote"
sleep 1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Generic curl install for distrobox"
sleep 1
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

# TODO: Looking Glass install in flatpak format

# apt cmd for jackett
#sudo apt install gnupg ca-certificates
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
#echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
#sudo apt update
#sudo apt install curl mono-devel
#curl -L -O $( curl -s https://api.github.com/repos/Jackett/Jackett/releases | perl -pe 's/^.+?browser_download_url.+?(https.+?Jackett.Binaries.LinuxAMDx64.tar.gz).+/$1/;' )

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

# optional flatpaks, a lot of distros have these preinstalled
while
	read -p "Install other preferred flatpaks such as libreoffice and celluloid? These are usually preinstalled on distros. (y/N)" moarflatpak
do
	case $moarflatpak in
		([yY][eE][sS] | [yY]) flatpak install flathub org.libreoffice.LibreOffice io.github.celluloid_player.Celluloid;;
		(*) break;;
	esac
done