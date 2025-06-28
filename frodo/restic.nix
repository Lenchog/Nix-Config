{ config, ... }:
{
  services.restic.backups = {
    b2 = {
      paths = [
        "/var/lib/minecraft/final-clan/world"
        "/var/lib/garf/scores.db"
				"/var/lib/syncthing"
				"/var/lib/photoprism"
				"/var/lib/vaultwarden"
      ];
      repository = "/var/restic";
      passwordFile = config.sops.secrets."resticPassword".path;
      initialize = true;
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
        "--keep-yearly 75"
      ];
    };
  };
}
