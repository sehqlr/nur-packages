{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.ipfs-node;
in {
  options.services.ipfs-gateway.enable =
    lib.mkEnableOption "Enable an IPFS node with HTTP gateway port firewalled";

  config = lib.mkIf cfg.enable {
    networking.allowedTCPPorts = [ 4001 5001 ];
    services.ipfs.enable = true;
  };
}
