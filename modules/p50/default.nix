{ config, lib, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  environment = {
    systemPackages = with pkgs; [ commonsCompress ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  fonts.fontconfig.enable = true;

  home-manager.users.sam = {
    home.packages = with pkgs; [
      firefox-wayland
      imv
      manuskript
      paperwork
      xdg-desktop-portal-wlr
    ];

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
  fonts.fontconfig.defaultFonts.monospace = [ "FiraCode Mono" ];

  hardware.pulseaudio.enable = true;

  networking.hostName = "p50";
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;
  networking.networkmanager.enable = true;

  nix.trustedUsers = [ "root" "sam" ];

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.flatpak.enable = true;

  services.jupyterhub = {
    enable = true;
    kernels = {
      nltk = let
        env = (pkgs.python3.withPackages (pypkgs:
          with pypkgs; [
            ipykernel
            nltk
            matplotlib
            numpy
            beautifulsoup4
          ]));
      in {
        displayName = "Python 3 for NLP";
        argv = [
          "${env.interpreter}"
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
        language = "python";
        logo32 =
          "${env}/${env.sitePackages}/ipykernel/resources/logo-32x32.png";
        logo64 =
          "${env}/${env.sitePackages}/ipykernel/resources/logo-64x64.png";
      };
    };
  };

  time.timeZone = "America/Chicago";

  users.users.sam = {
    description = "Sam Hatfield <hey@samhatfield.me>";
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  virtualisation.podman.enable = true;

  xdg.portal.enable = true;

}

