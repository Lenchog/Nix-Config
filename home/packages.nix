{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
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
    wl-clipboard
    # Apps
    spotify
    ldtk
    bottom
    obsidian
    webcord
    pavucontrol
    audacity
    (prismlauncher.override {
      jdks = [
        pkgs.jdk25
        pkgs.jdk8
      ];
    })
    hyprshot
    nix-search-cli
    easyeffects
  ];
}
