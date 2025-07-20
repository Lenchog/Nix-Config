{ config, pkgs, ... }:
let
  full = [
    "/var/lib/garf/scores.db"
    "/var/lib/syncthing"
    "/var/lib/photoprism"
    "/var/lib/vaultwarden"
  ];
  minimal = [
    "/var/lib/garf/scores.db"
    "/var/lib/vaultwarden"
  ];
  pruneOpts = [
    "--keep-daily 3"
    "--keep-weekly 3"
    "--keep-monthly 3"
    "--keep-yearly 9999"
  ];
in
{
  services.restic.backups = {
    # idk why this is called this but don't wanna change it
    b2 = {
      paths = full;
      repository = "/var/restic";
      passwordFile = config.sops.secrets."resticPassword".path;
      initialize = true;
      pruneOpts = pruneOpts;
    };
    hard-drive = {
      paths = full;
      repository = "/media/hard-drive/restic";
      pruneOpts = pruneOpts;
      passwordFile = config.sops.secrets."resticPassword".path;
      initialize = true;
    };
    google-drive = {
      paths = minimal;
      repository = "/media/google-drive/restic";
      pruneOpts = pruneOpts;
      passwordFile = config.sops.secrets."resticPassword".path;
      initialize = true;
    };
  };
  systemd = {
    timers.rclone = {
      enable = true;
      timerConfig = {
        OnCalendar = "daily";
      };
    };
    services.rclone = {
      description = "Backup restic backups to Google Drive";
      serviceConfig = {
        ExecStart = "${pkgs.rclone}/bin/rclone copy /media/google-drive/restic google-drive:backup --config /root/.config/rclone/rclone.conf";
      };
    };
  };
}
