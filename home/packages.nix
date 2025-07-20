{ pkgs, ... }:
{
  home.packages = with pkgs; [
    mangohud # Overlay, like MSI Afterburner
    git
    gh
    # Utilities
    zip
    unzip
    fd # lists files, needed for telescope and also cool finding thingo
    ripgrep # grep alternative
    fzf
    lsd
    ncdu
    # Apps
    spotify
    ldtk
    bottom
    obsidian
    webcord
    pavucontrol
    audacity
    prismlauncher
    hyprshot
    nix-search-cli
    easyeffects
  ];
}
