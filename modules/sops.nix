{
  inputs,
  config,
  lib,
  specialArgs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    age.keyFile = "/home/lenny/.config/sops/age/keys.txt";
    secrets = {
      garf_key = { };
      wireguard-frodo-private = { };
      hashedPassword = {
        neededForUsers = true;
      };
      resticPassword = { };
      email = { };
      desec-token = lib.mkIf specialArgs.server {
        owner = config.users.users.acme.name;
      };
      photoprism-password = { };
      ssh-private-key = {
        path = "/home/lenny/.ssh/nixos_ed25519";
        owner = "lenny";
        mode = "0600";
      };
      nix-key = {
        path = "/etc/nix/nix-key.priv";
        mode = "0600";
      };
    };
  };
}
