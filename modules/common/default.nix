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
    home = {
      homeDirectory = "/home/sam";
      packages = with pkgs; [
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        cabal-install
        cachix
        httpie
        nixfmt
        nix-linter
        nix-prefetch-scripts
        pamixer
        pandoc
        python37Packages.editorconfig
        ripgrep
        stack
        sway-contrib.grimshot
        wl-clipboard
        wob
        wofi
      ];
      username = "sam";
    };

    nixpkgs.config = import ./nixpkgs-config.nix;

    programs.bat.enable = true;

    programs.command-not-found.enable = true;

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.gh.enable = true;

    programs.git = {
      enable = true;
      aliases = {
        graph = "log --graph --oneline --decorate";
        staged = "diff --cached";
        wip =
          "for-each-ref --sort='authordate:iso8601' --format='%(color:green)%(authordate:relative)%09%(color:white)%(refname:short)' refs/heads";
      };
      extraConfig.init.defaultBranch = "main";
      ignores = [ "result" ];
      userEmail = "hey@samhatfield.me";
      userName = "sehqlr";
    };

    programs.go.enable = true;

    programs.home-manager.enable = true;

    programs.htop.enable = true;

    programs.jq.enable = true;

    programs.kakoune = {
      enable = true;
      config = {
        colorScheme = "solarized-dark";
        hooks = [
          {
            name = "WinCreate";
            option = "^[^*]+$";
            commands = ''
              editorconfig-load
            '';
          }
          {
            name = "WinSetOption";
            option = "filetype=markdown";
            commands = ''
              set-option buffer lintcmd 'vale'
              set-option buffer formatcmd 'pandoc -f markdown -t markdown-smart -s'
              ghwiki-enable
            '';
          }
          {
            name = "BufCreate";
            option = "^.*lhs$";
            commands = "set-option-buffer filetype markdown";
          }
          {
            name = "InsertChar";
            option = "j";
            commands = ''
              try %{
                  exec -draft hH <a-k>jj<ret> d
                  exec <esc>
              }
            '';
          }
          {
            name = "BufCreate";
            option = "^.*nix$";
            commands = ''
              set-option buffer formatcmd 'nixfmt'
              set-option buffer lintcmd 'nix-linter'
            '';
          }
        ];
        numberLines.enable = true;
        showWhitespace.enable = true;
        ui.enableMouse = true;
        wrapLines = {
          enable = true;
          marker = "⏎";
          word = true;
        };
      };
      plugins = [ (import ../../default.nix { }).kakoune-ghwiki ];
    };

    services.kanshi.enable = true;

    programs.mako.enable = true;

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "bytes.zone" = {
          host = "git.bytes.zone";
          port = 2222;
          user = "git";
          identityFile = "~/.ssh/gitea";
        };
        "github" = {
          host = "github.com";
          user = "git";
          identityFile = "~/.ssh/github";
        };
        "gitlab" = {
          host = "gitlab.com";
          user = "git";
        };
        "sr.ht".host = "*sr.ht";
        "samhatfield.me" = {
          host = "samhatfield.me";
          user = "root";
          identityFile = "~/.ssh/terraform";
        };
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[λ](bold·green)";
          error_symbol = "[λ](bold·red)";
        };
      };
    };

    programs.taskwarrior = let keys = "${config.programs.taskwarrior.dataLocation}/keys"; in {
      enable = true;
      config = {
          taskd = {
              certificate = "${keys}/public.cert";
              key = "${keys}/private.key";
              ca = "${keys}/ca.cert";
              server = "samhatfield.me:53589";
              credentials = "personal/sam/2b6c0e0b-c371-4dbb-8169-718c806fe34b";
          };
      };
    };

    programs.termite.enable = true;

    programs.tmux = {
      enable = true;
      clock24 = true;
      extraConfig = ''
        set -g mouse on
      '';
      plugins = with pkgs; [{
        plugin = tmuxPlugins.tmux-colors-solarized;
        extraConfig = ''
          set -g @colors-solarized 'dark'
          set -g status-right ""
        '';
      }];
      terminal = "tmux-256color";
      shortcut = "a";
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-left = [ "sway/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [ "tray" ];
          modules = {
            "clock" = {
              tooltip = true;
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
              today-format = "<b><u>{}</u></b>";
              format = "{:%H:%M (%a)}";
            };
          };
        }
        {
          layer = "top";
          position = "bottom";
          modules-left = [ "sway/window" ];
          modules-center = [ ];
          modules-right = [ "network" "cpu" "memory" "battery" ];
          modules = {
            "network" = {
              format = "{ifname}";
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ifname} ";
              format-disconnected = "";
              tooltip-format = "{bandwidthUpBits} | {bandwidthDownBits}";
              tooltop-format-disconnected = "OFFLINE";
            };
          };
        }
      ];
      systemd.enable = true;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "httpie" "ipfs" "ripgrep" "sudo" "systemd" "tmux" ];
        theme = "af-magic";
      };
      shellAliases = {
        cat = "bat";
        hms = "home-manager switch";
        nixos = "sudo nixos-rebuild";
      };
    };

    services.lorri.enable = true;

    services.udiskie = {
      enable = true;
      tray = "always";
    };

    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = {
        bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
        input."type:touchpad".tap = "enabled";
        keybindings =
          let modifier = config.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+p" =
              "exec ${pkgs.wofi}/bin/wofi -S drun | ${pkgs.findutils}/bin/xargs swaymsg exec --";
            "XF86AudioRaiseVolume" =
              "exec ${pkgs.pamixer}/bin/pamixer -ui 2 && pamixer --get-volume > $SWAYSOCK.wob";
            "XF86AudioLowerVolume" =
              "exec ${pkgs.pamixer}/bin/pamixer -ud 2 && pamixer --get-volume > $SWAYSOCK.wob";
            "XF86AudioMute" =
              "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && ( pamixer --get-mute && echo 0 > $SWAYSOCK.wob || pamixer --get-volume > $SWAYSOCK.wob";
            "XF86MonBrightnessUp" =
              "exec light -A 5 && light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
            "XF86MonBrightnessDown" =
              "exec light -U 5 && light -G | cut -d'.' -f1 > $SWAYSOCK.wob";
          };
        menu =
          "exec ${pkgs.wofi}/bin/wofi -S run | ${pkgs.findutils}/bin/xargs swaymsg exec --";
        modifier = "Mod4";
        startup = [{
          command = "mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | wob";
        }];
        terminal = "${pkgs.termite}/bin/termite -e tmux";
      };
    };
    xdg.configFile."nix/nix.conf".source = ./nix.conf;

    xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  nix.autoOptimiseStore = true;
  nix.gc.automatic = true;

  services.ipfs = {
    enable = true;
    enableGC = true;
  };

  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;

  users.users.sam = {
    description = "Sam Hatfield <hey@samhatfield.me>";
    extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
