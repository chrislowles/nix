# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
	imports = [
		#"${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/t480"
		./hardware-configuration.nix # standard hardware scan config
	 ];

	# example for adding a simple ext4-based volume (WIP)
	#fileSystems."/mnt/BEEG" = {
		#device = "/dev/nvme0n2";
		#fsType = "ext4";
	#};

	# Bootloader.
	boot.loader = {
		timeout = null;
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};

	# networking
	networking = {
		hostName = "system";
		networkmanager.enable = true;
		# enables firewall and opens ports for spotify connect/local discovery features
		firewall = {
			enable = true;
			allowedTCPPorts = [ 57621 ];
			allowedUDPPorts = [ 5353 ];
		};
	};

	# Set your time zone.
	time.timeZone = "Australia/Sydney";

	# Select internationalisation properties.
	i18n = {
		defaultLocale = "en_AU.UTF-8";
		extraLocaleSettings = {
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
	};

	hardware = {
		logitech.wireless.enable = true; # for use with solaar
		sensor.iio.enable = true;
	};

	# Enable sound with pipewire.
	security.rtkit.enable = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	services = {
		hardware.openrgb.enable = true;
		# enable cups
		printing.enable = true;
		# openssh
		#openssh.enable = true;
		# sound w/ pipewire
		pulseaudio.enable = false;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
		# Enables GNOME, it's included apps and GDM, init Wayland session (xserver is legacy terminology for nix config)
		xserver = {
			enable = true;
			desktopManager.gnome.enable = true;
			displayManager.gdm = {
				enable = true;
				#wayland = true;
			};
			xkb = {
				layout = "au";
				variant = "";
			};
		};
		# gnome keyring
		gnome.gnome-keyring.enable = true;
		# udev for systray icons
		udev.packages = with pkgs; [ gnome-settings-daemon ];
	};

	environment.gnome.excludePackages = (with pkgs; [
		gnome-tour
		totem
	]);

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.chris = {
		isNormalUser = true;
		description = "Chris Lowles";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			ytmdesktop
			yt-dlp
			dupeguru
			the-powder-toy
			openrgb
			jamesdsp
			obs-studio
			audacity
			krita
			krita-plugin-gmic
			kdePackages.kdenlive
			sourcegit
			qbittorrent
			upscayl
			handbrake
			#yacreader
			picard
			vesktop
			zoom-us
			caprine
			freetube
			boatswain
			solaar
			libreoffice
			celluloid
			ludusavi
			limo
			prismlauncher
			steam-rom-manager
			protonup-qt
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

	programs = {
		# trying to get itch to work :(
		nix-ld = {
			enable = true;
			libraries = with pkgs; [];
			#libraries = options.programs.nix-ld.libraries.default ++ (pkgs.steam-run.fhsenv.args.multiPkgs pkgs) ++ (with pkgs; [ itch ]);
		};
		appimage = {
			enable = true;
			binfmt = true;
		};
		steam = {
			enable = true;
			remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
			localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
			gamescopeSession = {
				enable = true;
			};
		};
		gamemode = {
			enable = true;
		};
	};

	environment = {
		sessionVariables = {
			#NIXOS_OZONE_WL = "1";
			STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d"; # for protonup-qt
		};
		systemPackages = with pkgs; [
			git
			micro
 			wget
			steam-run
			mangohud
			firefox-bin
			chromium
			(chromium.override {
				enableWideVine = true;
				commandLineArgs = [
					"--enable-features=AcceleratedVideoEncoder"
					"--ignore-gpu-blacklist"
					"--enable-zero-copy"
				];
			})
			#itch
			#(itch.override { commandLineArgs = [ "--no-sandbox" ]; })
			# TODO: gnome minimal system packages
			gnome-settings-daemon
			# gnome extensions
			gnomeExtensions.appindicator
		];
	};

	system = {
		# Before changing this value read the docs for this option (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
		stateVersion = "25.05";
	};

	# auto upgrades
	system.autoUpgrade = {
		enable = true;
		dates = "02:00";
		randomizedDelaySec = "45min";
	};

	# garbage collection
	nix.gc = {
		automatic = true;
		dates = "00:00";
		options = "--delete-older-than 10d";
	};

	# nix store optimisation
	nix.optimise = {
		automatic = true;
		dates = [ "05:00" ];
	};

}