{ ... }:
{
	services.vaultwarden = {
		enable = true;
		dbBackend = "sqlite";
    config = {
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
        DOMAIN = "https://vault.lench.org";
        SIGNUPS_ALLOWED = true;
        ADMIN_TOKEN = "test";
        LOG_FILE = "/var/lib/bitwarden_rs/access.log";
      };
		};
}
