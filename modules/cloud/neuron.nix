{ config, pkgs, ... }:
let
  neuron-notes = import (builtins.fetchTarball "https://github.com/srid/neuron/archive/master.tar.gz") {};
  notesDir = "/srv/git/zettelkasten";
  htmlDir = "/srv/neuron";
in {
    security.acme.certs."neuron.samhatfield.me".email = "hey@samhatfield.me";

    services.nginx.virtualHosts."neuron.samhatfield.me" = {
        addSSL = true;
        enableACME = true;
        locations."/" = {
            root = htmlDir;
            index = "index.html";
        };
    };
    # generate HTML for neuron.samhatfield.me
    systemd.services.neuron-gen = {
        description = "Generate HTML for sehqlr's zettelkasten, with neuron";
        script = "${neuron-notes}/bin/neuron -d ${notesDir} gen -o ${htmlDir}";
    };
    systemd.timers.neuron-gen = {
        wantedBy = [ "timers.target" ];
        partOf = [ "neuron-gen.service" ];
        timerConfig.OnCalendar = "minutely";
    };

    # sync git repo for zettelkasten
    systemd.services.clone-zettelkasten = {
        description = "Clone sehqlr's zettelkasten";
        serviceConfig.Type = "oneshot";
        serviceConfig.WorkingDirectory = "/srv/git";
        script = "${pkgs.git}/bin/git clone https://git.bytes.zone/sehqlr/zettelkasten";
    };
    systemd.services.sync-zettelkasten = {
        description = "Use git-sync on sehqlr's zettelkasten";
        serviceConfig.Type = "oneshot";
        serviceConfig.WorkingDirectory = notesDir;
        script = "${pkgs.git-sync}/bin/git-sync sync";
    };
    systemd.timers.sync-zettelkasten = {
        wantedBy = [ "timers.target" ];
        partOf = [ "sync-zettelkasten.service" ];
        timerConfig.OnCalendar = "minutely";
    };
}