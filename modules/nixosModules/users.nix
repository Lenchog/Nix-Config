{ config, pkgs, ... }:
{
  flake.modules.nixos.users =
    { pkgs, config, ... }:
    {
      users = {
        mutableUsers = false;
        defaultUserShell = pkgs.zsh;
        users = {
          lenny = {
            hashedPasswordFile = config.sops.secrets."hashedPassword".path;
            isNormalUser = true;
            description = "Lenny";
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+0JZwpWuhY8CMrdD7SiOHqDPWV+TBgXrjYnxB0vc/T"
            ];
            extraGroups = [
              "networkmanager"
              "wheel"
              "dialout"
              "audio"
            ];
            home = "/home/lenny";
          };
          root = {
            hashedPasswordFile = config.sops.secrets."hashedPassword".path;
          };
        };
      };
    };
}
