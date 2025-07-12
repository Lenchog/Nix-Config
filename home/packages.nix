{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Useless Rice Stuff
    mangohud # Overlay, like MSI Afterburner
    dolphin-emu
    gh
    git
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
    blanket
    bottom
    obsidian
    webcord
    pavucontrol
    yt-dlp
    audacity
    prismlauncher
    hyprshot
    wl-clipboard
    nix-search-cli
    easyeffects
    (lutris.override {
      extraPkgs = pkgs: [
        wine-wayland
        shadps4
      ];
    })
  ];
}
