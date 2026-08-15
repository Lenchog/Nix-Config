{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.minecraft =
    { pkgs, ... }:
    {
      imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
      nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
      services.minecraft-servers = {
        enable = true;
        eula = true;
        dataDir = "/var/lib/minecraft";
        servers = {
          gtnh = rec {
            package = self.packages.${pkgs.system}.gtnh;
            files = {
              config = "${package}/lib/config";
              serverutilities = "${package}/lib/serverutilities";
              "serverutilities/serverutilities.cfg" = ./serverutilities.cfg;
              mods = "${package}/lib/mods";
              "mods/distanthorizons-alpha20.jar" = pkgs.fetchurl rec {
                pname = "distanthorizons";
                version = "alpha20";
                url = "https://github.com/DarkShadow44/DistantHorizonsStandalone/releases/download/${version}/${pname}-${version}.jar";
                sha256 = "FkhFzdK0QMGfp6g8NIwxL0SWsxrWlg4pFpi6ry1x75U=";
              };
            };
            jvmOpts = "-Xms10G -Xmx10G -XX:+UseZGC";
            serverProperties = {
              online-mode = false;
              allow-flight = true;
              announce-player-achievements = true;
              difficulty = 3;
              enable-command-block = true;
              level-name = "world";
              level-type = "rwg";
              max-build-height = 256;
              max-players = 20;
              motd = "\\u00a77GT: New Horizons\\u00a7r\\n\\u00a7bv2.9.0 Beta 2 \\u00a7e[Whitelist]";
              hide-online-players = true;
              op-permission-level = 4;
              server-name = "GTNH";
              server-port = 25565;
              spawn-protection = 1;
              view-distance = 8;
              white-list = true;
            };
          };
        };
      };
    };
}
