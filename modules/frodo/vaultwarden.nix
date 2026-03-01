{
  flake.modules.nixos.vaultwarden.services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      DOMAIN = "https://vault.lench.org";
      SIGNUPS_ALLOWED = true;
      ADMIN_TOKEN = "$argon2id$v=19$m=65540,t=3,p=4$mDmi9fWsgLsHU3rU2JdMiMt2bRaVIQUeyqoS9jgl2So$OmLymOkFPmy0ztXhblnJ+i1R485V+CmTPHI57UkEGIU";
      LOG_FILE = "/var/lib/vaultwarden/access.log";
      DATA_FOLDER = "/var/lib/vaultwarden";
      DATABASE_URL = "/var/lib/vaultwarden/db.sqlite3";
    };
  };
}
