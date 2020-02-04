{ config, lib, pkgs, ... }:
let cfg = config.services.yacy;
{
  option.services.yacy = {

  };

  config = lib.mkIf cfg.enable {

  };
}
