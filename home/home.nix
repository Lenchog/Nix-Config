{
  specialArgs,
  inputs,
  ...
}:
{
  home = {
    username = "lenny";
    stateVersion = "24.05";
  };
  programs = {
    home-manager.enable = true;
    firefox.enable = specialArgs.gui;
    wofi.enable = specialArgs.gui;
    git.enable = true;
    zsh.enable = true;
    zoxide.enable = true;
    nixvim.enable = true;
    helix.enable = true;
    niri.enable = specialArgs.gui;
		foot = {
			enable = specialArgs.gui;
			server.enable = true;
		};
    #slippi-launcher.enable = specialArgs.games;
  };
  services = {
    mako.enable = true;
		syncthing.enable = true;
  };
  stylix.enable = specialArgs.gui;
  gtk.enable = specialArgs.gui;
  wayland.windowManager.hyprland.enable = specialArgs.gui;
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.stylix.homeModules.stylix
    inputs.niri.homeModules.niri
    ../modules/options.nix
    ../scripts/wallpaper.nix
    ./mangohud.nix
    ./firefox.nix
    ./fastfetch.nix
    ./wofi.nix
    ./niri.nix
    ./git.nix
    ./hyprland.nix
    ./packages.nix
    ./zsh.nix
    ./themes.nix
    ./nixvim.nix
    ./helix.nix
    ./kitty.nix
    ./eww.nix
    ./mako.nix
    ./lf.nix
    ./ghostty.nix
  ];
}
