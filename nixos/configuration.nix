# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [
		#"${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/t480"
		# Include the results of the hardware scan
		./hardware-configuration.nix
	 ];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "laptop"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Australia/Sydney";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_AU.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_AU.UTF-8";
		LC_IDENTIFICATION = "en_AU.UTF-8";
		LC_MEASUREMENT = "en_AU.UTF-8";
		LC_MONETARY = "en_AU.UTF-8";
		LC_NAME = "en_AU.UTF-8";
		LC_NUMERIC = "en_AU.UTF-8";
		LC_PAPER = "en_AU.UTF-8";
		LC_TELEPHONE = "en_AU.UTF-8";
		LC_TIME = "en_AU.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "au";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		#jack.enable = true;
		# use the example session manager (no others are packaged yet so this is enabled by default, no need to redefine it in your config for now)
		#media-session.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	#services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.chris = {
		isNormalUser = true;
		description = "Chris Lowles";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			ytmdesktop
			yt-dlp
			luanti
			dupeguru
			vim
			#spotify
			the-powder-toy
			openrgb-with-all-plugins
			zed-editor
			jamesdsp
			peazip
			obs-studio
			audacity
			krita
			krita-plugin-gmic
			kdePackages.kdenlive
			qownnotes
			vscodium
			github-desktop
			qbittorrent
			jackett
			upscayl
			curtail
			handbrake
			yacreader
			picard
			discord
			zoom-us
			freetube
			boatswain
			solaar
			libreoffice
			celluloid
			# non-steam gaming/steam rom manager
			ludusavi
			limo
			prismlauncher
			steam-rom-manager
			azahar
			flycast
			mednaffe
			dolphin-emu
			simple64
			duckstation
			pcsx2
			rpcs3
			ppsspp
			cemu
			snes9x-gtk
		];
	};

	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
		dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Enables GNOME DE and GDM, init Wayland session (xserver is legacy terminology for nix config)
	services.xserver = {
		enable = true;
		displayManager.gdm = {
			enable = true;
			wayland = true;
		};
		desktopManager.gnome.enable = true;
	};

	environment.gnome.excludePackages = (with pkgs; [
		geary
		gnome-tour
		totem
	]);

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = [
		pkgs.git
 		pkgs.wget
		pkgs.gnome-settings-daemon
		pkgs.firefox-bin
		# minimal gnome install
		# gnome extentions
		pkgs.gnomeExtensions.appindicator
	];

	# ensure gnome-settings-daemon udev rules are enabled
	#services.udev.packages = with pkgs; [
  	# gnome.gnome-settings-daemon
	#];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?

}
