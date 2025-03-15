{
  pkgs,
  ...
}: {
  stylix = {
    image = ../wallpapers/kida.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = inputs.kleur.themes.${pkgs.system}.dark.base16;
    #opacity.terminal = 0.8;

    fonts = {
      monospace = {
				package = pkgs.nerd-fonts.iosevka;
				name = "Iosevka Nerd Font";
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
		iconTheme = {
			enable = true;
			package = pkgs.papirus-icon-theme;
			dark = "Papirus Dark";
		};
  };
	wayland.windowManager.hyprland.settings.monitor = [ "HDMI-A-1, highres, 0x0, 1.5" ];
  blur = false;
}
