{ config, pkgs, ... }: {
  environment.pathsToLink = [ "/share/zsh" ];
  programs.sway.enable = true;
  services.xserver.displayManager = {
      defaultSession = "sway";
      lightdm.enable = true;
      autoLogin = {
          enable = true;
          user = "sam";
      };
  };
  users.users.sam = {
      description = "Sam Hatfield <hey@samhatfield.me>";
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      isNormalUser = true;
      shell = pkgs.zsh;
  };
}