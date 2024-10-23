#!/bin/bash

# final touches after the fact, reclone repo and run this post-install

echo "full qemu setup"
sleep 1
sudo pacman -Syy qemu-full virt-manager libvirt iptables-nft dnsmasq openbsd-netcat
sed -i 's/^#unix_sock_group = \"libvirt\"/unix_sock_group = \"libvirt\"/' /etc/libvirt/libvirtd.conf
sed -i 's/^#unix_sock_ro_perms = \"0777\"/unix_sock_ro_perms = \"0777\"/' /etc/libvirt/libvirtd.conf
sed -i 's/^#unix_sock_rw_perms = \"0770\"/unix_sock_rw_perms = \"0770\"/' /etc/libvirt/libvirtd.conf
usermod -aG libvirt $USERNAME
sudo systemctl enable libvirtd

echo "adding direct flathub remote"
sleep 1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "generic curl install for distrobox"
sleep 1
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

echo "flatpak permissions and cleaner, distrobox gui and other preferred flatpaks"
sleep 1
flatpak install flathub \
com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep \
io.github.dvlv.boxbuddyrs com.feaneron.Boatswain org.kde.kdenlive io.freetubeapp.FreeTube com.discordapp.Discord org.qbittorrent.qBittorrent io.github.celluloid_player.Celluloid org.audacityteam.Audacity org.kde.krita io.github.shiftey.Desktop org.libreoffice.LibreOffice io.github.pwr_solaar.solaar org.upscayl.Upscayl com.spotify.Client io.github.peazip.PeaZip com.obsproject.Studio us.zoom.Zoom me.timschneeberger.jdsp4linux com.visualstudio.code com.valvesoftware.Steam com.steamgriddb.steam-rom-manager com.mojang.Minecraft uk.co.powdertoy.tpt io.itch.itch io.github.limo_app.limo net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2 org.flycast.Flycast org.musicbrainz.Picard org.blender.Blender org.gnome.meld