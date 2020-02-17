{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.ipfs-gateway;
  domain = config.networking.domain;
  fqdn = let d = config.networking.domain;
  in "${config.networking.hostname}.${strings.optionalString (d != null) d}";
in {
  options.ipfs-gateway.enable =
    lib.mkEnableOption "Enable a public IPFS gateway";
  options.ipfs-gateway.virtualHost = lib.mkOption {
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
    };

    virtualHosts."${cfg.virtualHost}" = let
      gatewayAddress = builtins.replaceStrings [ "/ipv4/" "/ipv6" "/tcp/" ] [
        "http://"
        "http://"
        ":"
      ] config.services.ipfs.gatewayAddress;
    in {
      forceSSL = true;
      enableAcme = true;
      locations."/".proxyPass = gatewayAddress;
    };
  };
}
