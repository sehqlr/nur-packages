{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.ipfs-gateway;
  domain = config.networking.domain;
  fqdn = let d = config.networking.domain;
  in "${config.networking.hostName}.${strings.optionalString (d != null) d}";
in {
  options.services.ipfs-gateway.enable =
    lib.mkEnableOption "Enable a public IPFS gateway";
  options.services.ipfs-gateway.virtualHost = lib.mkOption {
    type = types.str;
    default = fqdn;
    description = "Virtual Host to run service under";
  };

  config = lib.mkIf cfg.enable {
    services.ipfs.enable = true;
    services.nginx = {
      enable = true;
      statusPage = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."${cfg.virtualHost}" = let
        gatewayAddress = builtins.replaceStrings [ "/ip4/" "/ip6" "/tcp/" ] [
          "http://"
          "http://"
          ":"
        ] config.services.ipfs.gatewayAddress;
      in {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = gatewayAddress;
      };
    };
  };
}
