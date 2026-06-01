{ inputs, ... }:
{
  flake.modules.homeManager.stylix =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [ inputs.stylix.homeModules.stylix ];
      stylix = {
        enable = true;
        image = ../../wallpapers/mononoke.png;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
        opacity.terminal = 0.9;

        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.iosevka;
            name = "Iosevka Nerd Font";
          };
        };
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
        icons = {
          enable = true;
          package = pkgs.papirus-icon-theme;
          dark = "Papirus";
        };
        targets = {
          firefox = {
            profileNames = [ "lenchog" ];
          };
        };
      };
    };
}
