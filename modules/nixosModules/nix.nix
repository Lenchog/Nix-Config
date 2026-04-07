{
  flake.modules.nixos.nix-conf =
    { config, ... }:
    {
      nix = {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "nix-key:hSWnFY8bjaxrQs/nUjirSXeNruuy1KW6fCY3cURGzfY="
          ];
          secret-key-files = [ config.sops.secrets."nix-key".path ];
          auto-optimise-store = true;
          trusted-users = [ "@wheel" ];
        };
      };
    };
}
