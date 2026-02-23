{
  flake.modules.nixos.nix = {
    nix = {
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-public-keys = [ "nix-key:hSWnFY8bjaxrQs/nUjirSXeNruuy1KW6fCY3cURGzfY=" ];
        secret-key-files = [ config.sops.secrets."nix-key".path ];
        auto-optimise-store = true;
        trusted-users = [ "@wheel" ];
      };
    };
  };
}
