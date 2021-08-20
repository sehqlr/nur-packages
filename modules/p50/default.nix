{ config, lib, pkgs, ... }: {
  home-manager.users.sam = import ./hm.nix { };

  hardware.pulseaudio.enable = true;

  networking.hostName = "p50";
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  programs.steam.enable = true;

  services.flatpak.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  time.timeZone = "America/Chicago";
}
