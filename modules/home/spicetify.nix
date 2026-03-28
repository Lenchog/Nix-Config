{ inputs, ... }:
{
  flake.modules.homeManager.spicetify =
    { pkgs, ... }:
    {
      imports = [ inputs.spicetify-nix.homeManagerModules.default ];
      programs.spicetify =
        let
          spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            beautiful-lyrics
            hidePodcasts
            shuffle # shuffle+ (special characters are sanitized out of extension names)
            songStats
            wikify
          ];
        };
    };
}
