{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: prev: {
      ukmm = prev.ukmm.overrideAttrs (oldAttrs: rec {
        version = "0.16.0";
        src = prev.fetchFromGitHub {
          owner = "GingerAvalanche";
          repo = "ukmm";
          tag = "v0.16.0";
          hash = "sha256-jnZJXWni8UpdnEvYff1rtAQPrc3l7c/VLoyLGUrQTU4=";
        };
        cargoDeps = final.rustPlatform.fetchCargoVendor {
          inherit src;
          hash = "sha256-vNpKaFMeKO2EM7XQ4rgVRJwgVBQueMrJ5xN8eD3EQNk=";
        };
        # cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
        #   prev.lib.const {
        #     name = "${oldAttrs.pname}-vendor.tar.gz";
        #     inherit src;
        #     outputHash = "sha256-QCEyl5FZqECYYb5eRm8mn+R6owt+CLQwCq/AMMPygE0=";
        #   }
        # );
      });
    })
  ];
  home.packages = with pkgs; [
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
    cemu
    ukmm
    reaper
    vital
    spotify
    ldtk
    bottom
    obsidian
    webcord
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
    hyprshot
    nix-search-cli
    easyeffects
  ];
}
