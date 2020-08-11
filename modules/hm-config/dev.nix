{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [ python37Packages.editorconfig ];

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  programs.kakoune.enable = true;
  programs.kakoune.config = {
    colorScheme = "solarized-dark";
    hooks = [{
      name = "WinCreate";
      option = "^[^*]+$";
      commands = "editorconfig-load";
    }];
    numberLines.enable = true;
    showWhitespace.enable = true;
    ui.enableMouse = true;
  };

  programs = {
    git = {
      enable = true;
      aliases = {
        graph = "log --graph --oneline --decorate";
        staged = "diff --cached";
      };
      ignores = [ "result" "*~" ".#*" ];
      signing.key = "hey@samhatfield.me";
      signing.signByDefault = true;
      userEmail = "hey@samhatfield.me";
      userName = "sehqlr";
      extraConfig = { init = { defaultBranch = "main"; }; };
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "github" = {
          host = "github.com";
          user = "git";
        };
        "gitlab" = {
          host = "gitlab.com";
          user = "git";
        };
        "sr.ht" = { host = "*sr.ht"; };
        "bytes.zone" = {
          host = "git.bytes.zone";
          user = "git";
          port = 2222;
        };
      };
    };
  };
  services.lorri.enable = true;
}

