{
  flake.modules.homeManager.packages =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        # Utilities
        git
        gh
        zip
        unzip
        ripgrep
        ncdu
        wl-clipboard
        nix-search-cli
        bottom
        yazi
        # Apps
        tetrio-desktop
        nautilus
        vesktop
        pavucontrol
        (prismlauncher.override {
          jdks = [
            pkgs.javaPackages.compiler.temurin-bin.jdk-25
            pkgs.javaPackages.compiler.temurin-bin.jdk-21
            pkgs.jdk8
          ];
        })
        easyeffects
      ];
    };
}
