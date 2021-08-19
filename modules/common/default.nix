{ config, lib, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  environment = {
    systemPackages = with pkgs; [ commonsCompress ];
    pathsToLink = [ "/share/zsh" ];
  };

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  fonts.fontconfig.enable = true;

  home-manager.users.sam = import ./hm.nix { };

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  nix.autoOptimiseStore = true;
  nix.gc.automatic = true;
  nix.trustedUsers = [ "root" "sam" ];

  nixpkgs.config = import ./nixpkgs-config.nix;

  services.ipfs = {
    enable = true;
    enableGC = true;
  };

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

  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;

  users.users.sam = {
    description = "Sam Hatfield <hey@samhatfield.me>";
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  virtualisation.podman.enable = true;

  xdg.portal.enable = true;
}
