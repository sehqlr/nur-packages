{ config, lib, pkgs, ... }:
let cfg = config.services.yacy;
    pkg = pkgs.yacy;
{
  option.services.yacy = {
    enable = lib.mkEnableOption "YaCy p2p search engine";
  };

  config = lib.mkIf cfg.enable {
    users.users.yacy = {
      createHome = true;
      description = "YaCy search engine user";
      group = "yacy";
      home = "/var/lib/yacy";
    };

    systemd.services.yacy = {
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      description = "YaCy, the P2P web search engine";
      serviceConfig = {
        Type = "forking";
        User = "yacy";
        ExecStart = ''${pkgs.yacy}/startYACY.sh'';
        ExecStop = ''${pkgs.yacy}/stopYACY.sh'';
      };
    };
  };
}
