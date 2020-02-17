{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  imports = [ ./dev ];

  home.packages = with pkgs; [
    gnupg
    gpa
    pass
    qtpass
    ripgrep
    xclip
    file
    pandoc
    graphviz
    transmission-gtk
  ];
  nixpkgs.config.allowUnfree = true;

  programs.htop.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "3759E9087871E845B0621E00F6BE8F0DE65D9666" ];
  }

programs.bat.enable = true;
programs.command-not-found.enable = true;
programs.firefox.enable = true;
programs.fzf.enable = true;
programs.fzf.enableZshIntegration = true;
programs.feh.enable = true;
programs.rofi = {
            enable = true;
            theme = "lb"; # rofi-theme-selector
          };
programs.termite.enable = true;
programs.zathura.enable = true;

          services.flameshot.enable = true;
          services.kdeconnect = {
            enable = true;
            indicator = true;
          };
          services.blueman-applet.enable = true;

    programs.zsh = {
        enable = true;

        defaultKeymap = "vicmd";
        enableCompletion = true;
        oh-my-zsh.enable = true;
        oh-my-zsh.plugins =
          [ "copyfile" "extract" "httpie" "pass" "sudo" "systemd" ];
        oh-my-zsh.theme = "af-magic";
        shellAliases.nixos = "sudo nixos-rebuild";
    };


  # xsession = {
  #   enable = true;
  #   preferStatusNotifierItems = true;
  #   windowManager = {
  #     xmonad = {
  #       enable = true;
  #       enableContribAndExtras = true;
  #       config = ./xmonad.hs;
  #     };
  #   };
  # };
}
