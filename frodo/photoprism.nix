{ pkgs, config, ... }:
{
 services.photoprism = {
    enable = true;
    port = 2342;
    originalsPath = "/var/lib/private/photoprism/originals";
    address = "0.0.0.0";
    settings = {
      PHOTOPRISM_ADMIN_USER = "escott";
      #PHOTOPRISM_ADMIN_PASSWORD = "${config.sops.secrets."photoprism-password"}";
			PHOTOPRISM_ADMIN_PASSWORD = "beanbag";
      PHOTOPRISM_DEFAULT_LOCALE = "en";
      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      #PHOTOPRISM_SITE_URL = "http://photos.lench.org";
      PHOTOPRISM_SITE_URL = "http://192.168.0.154:2342";
      PHOTOPRISM_SITE_TITLE = "PhotoPrism";
    };
  };
  services.mysql = {
    enable = true;
    dataDir = "/data/photoprism";
    package = pkgs.mariadb;
    ensureDatabases = [ "photoprism" ];
    ensureUsers = [ {
      name = "photoprism";
      ensurePermissions = {
        "photoprism.*" = "ALL PRIVILEGES";
      };
    } ];
  };
}
