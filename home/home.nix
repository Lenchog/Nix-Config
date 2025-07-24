{ specialArgs, inputs, ... }:
with specialArgs;
{
  home = {
    username = "lenny";
    stateVersion = "24.05";
  };
  programs = {
    home-manager.enable = true;
    firefox.enable = gui;
    wofi.enable = gui;
    git.enable = true;
    zsh.enable = true;
    zoxide.enable = true;
    nixvim.enable = true;
    helix.enable = true;
    niri.enable = gui;
    foot = {
      enable = gui;
      server.enable = gui;
    };
  };
  services = {
    mako.enable = gui;
    syncthing.enable = true;
  };
  stylix.enable = gui;
  gtk.enable = gui;
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
