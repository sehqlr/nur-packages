{ config, lib, pkgs, ... }: {
  home-manager.users.sam = {
    services.kanshi.profiles = {
      undocked = {
        outputs = [{
          criteria = "eDP-1";
          position = "0,0";
        }];
      };
      "three_monitors_on_reboot" = {
        outputs = [
          {
            criteria = "DP-4";
            position = "3840,0";
          }
          {
            criteria = "DP-6";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            position = "1920,0";
          }
        ];
      };

      "three_monitors" = {
        outputs = [
          {
            criteria = "DP-5";
            position = "3840,0";
          }
          {
            criteria = "DP-8";
            position = "0,0";
          }
          {
            criteria = "eDP-1";
            position = "1920,0";
          }
        ];
      };
    };
  };

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
