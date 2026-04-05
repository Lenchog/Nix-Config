{ inputs, ... }:
{
  flake.modules.nixos.gui =
    { pkgs, config, ... }:
    {
      imports = [
        inputs.musnix.nixosModules.musnix
      ];
      # hardware.nvidia.package = pkgs.linuxPackages.nvidiaPackages.beta;
      # absolutely no idea why this doesn't work when it's in the aragorn module
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      musnix.enable = true;
      programs = {
        uwsm = {
          enable = true;
          waylandCompositors = {
            niri = {
              prettyName = "niri";
              binPath = "${pkgs.niri}/bin/niri-session";
            };
          };
        };
        dconf.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        gamemode.enable = true;
        gamescope.enable = true;
        steam = {
          enable = true;
          gamescopeSession.enable = true;
          package = pkgs.steam.override {
            extraPkgs =
              pkgs: with pkgs; [
                libxcursor
                libxi
                libxinerama
                libxscrnsaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
              ];
          };
        };
      };
      services = {
        greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd '${pkgs.uwsm}/bin/uwsm start -F default'";
            };
          };
        };
        blueman.enable = true;
        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          pulse.enable = true;
        };
      };
      hardware = {
        steam-hardware.enable = true;
        bluetooth.enable = true;
        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };
    };
}
