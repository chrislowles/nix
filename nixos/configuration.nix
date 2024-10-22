{ config, pkgs, lib, ... }: {
	nixpkgs.config.allowUnfree = true;
	imports = [
		./hardware-configuration.nix
	];
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos-system";
	networking.networkmanager.enable = true;

	time.timeZone = "Australia/Sydney";

	i18n.defaultLocale = "en_US.UTF-8";

	programs.hyprland = {
		enable = true;
		nvidiaPatches = true;
		xwayland.enable = true;
	};

	environment = {
		systemPackages = [
			pkgs.waybar
			libnotify

			# wallpapers
			swww

			# terminal emulator
			kitty

			# app launcher
			rofi-wayland

			(pkgs.waybar.overrideAttrs (oldAttrs: {
				mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
			}))
		];
		sessionVariables = {
			WLR_NO_HARDWARE_CURSORS = "1";
			NIXOS_OZONE_WL = "1";
		};
	};

	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	sound = {
		enable = true;
	};

	security.rtkit.enable = true;

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	hardware = {
		opengl.enable = true;
		nvidia.modesetting.enable = true;
	};
}