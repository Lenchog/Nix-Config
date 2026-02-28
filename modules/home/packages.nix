{
  flake.modules.homeManager.packages =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        xwayland-satellite
        mangohud
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
        reaper
        vital
        spotify
        ldtk
        bottom
        obsidian
        vesktop
        pavucontrol
        audacity
        (prismlauncher.override {
          jdks = [
            pkgs.javaPackages.compiler.temurin-bin.jdk-25
            pkgs.javaPackages.compiler.temurin-bin.jdk-21
            pkgs.jdk21
            pkgs.jdk17
            pkgs.jdk8
          ];
        })
        nix-search-cli
        easyeffects
      ];
    };
}
