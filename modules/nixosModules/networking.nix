{
  config,
  lib,
  ...
}:
{
  flake.modules.nixos.networking = {
    networking = {
      useDHCP = lib.mkDefault true;
      networkmanager.enable = true;
      nameservers = [ "192.168.1.42" ];
    };
    time.timeZone = "Australia/Sydney";
    i18n.defaultLocale = "en_AU.UTF-8";
    programs.ssh.extraConfig = ''
      Host frodo
        Hostname lench.org
        Port 2121
        User lenny
        IdentityFile ${config.sops.secrets."ssh-private-key".path}
    '';
  };
}
