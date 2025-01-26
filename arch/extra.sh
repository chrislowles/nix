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
newgrp libvirt

# locales for australia, iso codes too
# en_AU.UTF-8
# en_AU ISO-8859-1

# install custom bashrc commands, shortcuts to common commands, push this into config somehow
curl -Sk https://raw.githubusercontent.com/chrislowles/nix/main/arch/.bashrc >> ~/.bashrc
source ~/.bashrc

# read command needed for lsp/zam shortcut flush, if we're to install them
#echo '[Desktop Entry]
#Hidden=true' > /tmp/1
#find /usr -name "*lsp_plug*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}
#find /usr -name "*zam*desktop" 2>/dev/null | cut -f 5 -d '/' | xargs -I {} cp /tmp/1 ~/.local/share/applications/{}

echo "adding direct flathub remote"
sleep 1
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "generic curl install for distrobox"
sleep 1
curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

# echo "flatpak permissions and cleaner, distrobox gui and other preferred flatpaks"
sleep 1
# flatpak install flathub \