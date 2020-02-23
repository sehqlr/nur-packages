{ config, lib, pkgs, ... }:
let cfg = config.services.yacy;
{
  option.services.yacy = {
    enable = lib.mkEnableOption "YaCy p2p search engine";
  };

  config = lib.mkIf cfg.enable {
    # create yacy user
    users.users.yacy = {
      createHome = true;
      description = "YaCy search engine user";
      group = "yacy";
      home = "/var/lib/yacy";
      packages = [ pkgs.jdk ];
    };
  };
}
