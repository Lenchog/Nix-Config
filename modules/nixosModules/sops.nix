{ inputs, ... }:
{
  flake.modules.nixos.sops =
    {
      config,
      lib,
      ...
    }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        age.keyFile = "/home/lenny/.config/sops/age/keys.txt";
        secrets = {
          hashedPassword = {
            neededForUsers = true;
          };
          email = { };
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
    };
}
