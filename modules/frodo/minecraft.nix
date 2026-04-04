{
  lib,
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
            };
            symlinks = {
              "mods/distanthorizons-alpha18.jar" = pkgs.fetchurl rec {
                pname = "distanthorizons";
                version = "alpha18";
                url = "https://github.com/DarkShadow44/DistantHorizonsStandalone/releases/download/${version}/${pname}-${version}.jar";
                sha256 = "DVwZmTONqzl7VXViwk9m6EsbK8GRRuydwZfMPLUSmr4=";
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
              max-players = 5;
              motd = "\\u00a77GT: New Horizons\\u00a7r\\n\\u00a7bv2.8.4 \\u00a7e[Whitelist]";
              hide-online-players = true;
              op-permission-level = 4;
              server-name = "GT: New Horizons Server";
              server-port = 25564;
              spawn-protection = 1;
              view-distance = 8;
              white-list = true;
            };
          };
          cms-0 = {
            package = pkgs.fabricServers.fabric-1_21_11;
            serverProperties = {
              resource-pack = "https://cdn.modrinth.com/data/HfNmMQ9E/versions/S8Oe9FyR/Sparkles_1.21.x_v1.1.6.zip";
              resource-pack-sha1 = "8cbd7950b028b7191f62ba2fba8d463283d42619";
              resource-pack-prompt = "This is for the Incendium items";
              server-port = 25564;
              difficulty = "hard";
              motd = "hello cms buddies";
              max-world-size = 2500;
              online-mode = true;
              white-list = true;
              enable-command-block = true;
            };
            jvmOpts = "-Xms5G -Xmx5G -XX:+UseZGC";
            symlinks."config/Geyser-Fabric/packs" = pkgs.linkFarmFromDrvs "packs" (
              builtins.attrValues {
                Sparkles = pkgs.fetchurl {
                  # this is kinda weird
                  url = "file://${./.}/incendium-pack.mcpack";
                  sha256 = "G8QN4+hyyiMkZ5a1nE44fz4es8d0aaw8Poe5ejT7U4c=";
                };
              }
            );
            symlinks."mods" = pkgs.linkFarmFromDrvs "mods" (
              builtins.attrValues {
                # Terrain & Structures
                DungeonsAndTaverns = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/tpehi7ww/versions/rJ0Y6xDT/dungeons-and-taverns-v5.1.0.jar";
                  sha256 = "jca+mw6hlXYBl8u6ZqC3cMbpkU51NEhdyrLgNOhfRRw=";
                };
                Terralith = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/TFW9ZxPQ/Terralith_1.21.x_v2.5.14.jar";
                  sha256 = "3mLFiOb5f+KgkjyQVBuRYv7MoPX9h6uusJpevlQg238=";
                };
                Nullscape = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/jFDyNQ0I/Nullscape_1.21.x_v1.2.16.jar";
                  sha256 = "DfGc3JbM69Wm2UGMOnEGYdd3S3mLoh9HWCG9Kqk02z8=";
                };
                Incendium = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/ZVzW5oNS/versions/BUigTHnK/Incendium_1.21.x_v5.4.10.jar";
                  sha256 = "kJ/bQktsEYC37pqHRXCrRMp+Zfoz435BMrtnuqS6r2k=";
                };
                # Features
                RightClickHarvest = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/Cnejf5xM/versions/MJkjKHul/rightclickharvest-fabric-4.6.1%2B1.21.11.jar";
                  sha256 = "7shJvGGe8n5HgBczTyVC30Kh0PanLISwPpmGQZt2CzQ=";
                };
                SimpleVoiceChat = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/TE9flmQz/voicechat-fabric-1.21.11-2.6.14.jar";
                  sha256 = "iW2FfgfxqIgxyJYfeEgpSlEGYOjfAnLsrx4+Y4rrV2w=";
                };
                VoiceChatInteractions = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/qsSP2ZZ0/versions/9PqoA83N/vcinteraction-fabric-1.21.11-1.0.8.jar";
                  sha256 = "eq3Sj9jyFgvfkbZEFqRYMCGSUqbQUaQn8p5aEhrjvSU=";
                };
                NoChatReports = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/rhykGstm/NoChatReports-FABRIC-1.21.11-v2.18.0.jar";
                  sha256 = "FIAjmJ8BT98BLlDYpDp1zErTkZn4mBT1yMo43N7+ELg=";
                };
                DoubleDoors = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/JrvR9OHr/versions/roVanbyg/doubledoors-1.21.11-7.2.jar";
                  sha256 = "8bqjMJn4a5cN28FJkPP3SWRLb8gbjjU0A0ysDE1sVpc=";
                };
                Appleskin = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/59ti1rvg/appleskin-fabric-mc1.21.11-3.0.8.jar";
                  sha256 = "BP6De+jxC7XmuZkjhZRGbFm9tkGlRRLxnx5nJB2IKuM=";
                };
                DeathCount = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/JaEZg1D1/versions/YQjXpK5d/death-count-1.0.jar";
                  sha256 = "RmmyvPxZoDDggdPUmF5roWjeI30hSuq1PdZeq0L2HPA=";
                };

                # OpenPartiesAndClaims = pkgs.fetchurl {
                #   url = "";
                #   sha256 = "";
                # };
                # HorseMan = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/qIv5FhAA/versions/eJaVgnuB/horseman-fabric-1.21.11-1.7.2.jar";
                #   sha256 = "Eu9bzXxXEzGh1J0sGX0HD6QePm3eazAhSxaOMfmcatQ=";
                # };
                # CropsLoveRain = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/cRci7UZp/versions/lwcJJsVT/cropsloverain-3.2.0.jar";
                #   sha256 = "ZoLWN2PWaKvCNI8kqVmzjONi+cCBxI532DBBa1QGV5w=";
                # };
                FabricExporter = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/dbVXHSlv/versions/D7LrQrIU/fabricexporter-1.0.20.jar";
                  sha256 = "tdZ0EShzc7ALQfAhN6iDCN3zPOqw391VYuLckHvmKB0=";
                };

                # bedrock
                Geyser = pkgs.fetchurl {
                  name = "geyser.jar";
                  url = "https://download.geysermc.org/v2/projects/geyser/versions/2.9.4/builds/1092/downloads/fabric";
                  sha256 = "tR79omjxEzwIGT/IRi4iIiOfkJXTpn8B2KsAm18dHzQ=";
                };
                Floodgate = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/bWrNNfkb/versions/wzwExuYr/Floodgate-Fabric-2.2.6-b54.jar";
                  sha256 = "KVfeM69JWnYBpTyKfGMbXH9SayR+/GJ50RWxd7Y258g=";
                };

                # Anti cheat
                # AntiXRay = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/sml2FMaA/versions/I2sZQFG8/antixray-fabric-1.4.13%2B1.21.11.jar";
                #   sha256 = "gmdELW6xegrpFZ/9wLaw57G8WwHnKfoZMHB8mN/iz4k=";
                # };
                # SeedGuard = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/7e8ji5y2/versions/69VbewCw/seedguard%2B1.21.9-1.0.1.jar";
                #   sha256 = "a9+yO+baaHW3+OwICy+HTyA8ok9hdK9HBa3wCDaSxdk=";
                # };
                # Ledger = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/LVN9ygNV/versions/c1d39lju/ledger-1.3.19.jar";
                #   sha256 = "rQNNR42Ewz5mBJLUN1d5HGUOoPLWkdmOEf2Nb7iRGuE=";
                # };

                # Performance
                Lithium = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/qvNsoO3l/lithium-fabric-0.21.3%2Bmc1.21.11.jar";
                  sha256 = "hsG97K3MhVgBwvEMnlKJTSHJPjxSl8qDJwdN3RIeXFo=";
                };
                Chunky = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/fALzjamp/versions/1CpEkmcD/Chunky-Fabric-1.4.55.jar";
                  sha256 = "M8vZvODjNmhRxLWYYQQzNOt8GJIkjx7xFAO77bR2vRU=";
                };
                FerriteCore = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/uXXizFIs/versions/Ii0gP3D8/ferritecore-8.2.0-fabric.jar";
                  sha256 = "92vXYMv0goDMfEMYD1CJpGI1+iTZNKis89oEpmTCxxU=";
                };
                Krypton = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
                  sha256 = "lCkdVpCgztf+fafzgP29y+A82sitQiegN4Zrp0Ve/4s=";
                };
                # C2ME = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/VSNURh3q/versions/olrVZpJd/c2me-fabric-mc1.21.11-0.3.6.0.0.jar";
                #   sha256 = "DwWNNWBfzM3xl+WpB3QDSubs3yc/NMMV3c1I9QYx3f8=";
                # };
                Spark = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/l6YH9Als/versions/1CB3cS0m/spark-1.10.156-fabric.jar";
                  sha256 = "Nu0Tj/3iovH8sy7LzH+iG+rxYR4APRnjrUCVSHPlcvo=";
                };
                ServerCore = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/zg8VIycZ/servercore-fabric-1.5.15%2B1.21.11.jar";
                  sha256 = "78ehY/DFOdA8XsQsCS+b5WoP6GZrhxpjCCUC73kzBRA=";
                };
                # dependencies
                Fabric = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/i5tSkVBH/fabric-api-0.141.3%2B1.21.11.jar";
                  sha256 = "hsRTqGE5Zi53VpfQOwynhn9Uc3SGjAyz49wG+Y2/7vU=";
                };
                Collective = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/T8rv7kwo/collective-1.21.11-8.13.jar";
                  sha256 = "95qgCxWb4splQhVXhyk50ao1MvT5EGb6OLirnAJl0u8=";
                };
                FabricLanguageKotlin = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/ViT4gucI/fabric-language-kotlin-1.13.9%2Bkotlin.2.3.10.jar";
                  sha256 = "/s1ebdaudoFLqSE2tBeRLBmxnsdupFHO3kcs0pzez5E=";
                };
                ForgeConfigAPIPort = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/ohNO6lps/versions/uXrWPsCu/ForgeConfigAPIPort-v21.11.1-mc1.21.11-Fabric.jar";
                  sha256 = "MaBoaQT60c/esdawEawcIoCZDW52rCQWRoFH4iRrTbE=";
                };
                ClothConfig = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/9s6osm5g/versions/xuX40TN5/cloth-config-21.11.153-fabric.jar";
                  sha256 = "ikDITl7N5SWs+2xOE7gALaz8o++VNNf69ugEllb0I8g=";
                };
                Architectury = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/uNdfrcQ8/architectury-19.0.1-fabric.jar";
                  sha256 = "ZhOV1vC+8NOnlOLbdN9WAMc4e6b7lGsXIxWXcgGmZ8c=";
                };
                JamLib = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/IYY9Siz8/versions/SUWZN0xp/jamlib-fabric-1.3.5%2B1.21.11.jar";
                  sha256 = "Zu9XDSqm+6VSb5UTpZbPX1TosPvcdHMO7aaw4PwxF0s=";
                };
              }
            );
          };
        };
      };
      services.haproxy = {
        enable = true;
        config = lib.mkDefault ''
          global
            log stderr format iso local7
          defaults
            mode tcp
            log global
            option tcplog
            maxconn 20000
            timeout client 200s
            timeout server 200s
            timeout connect 20s
          frontend minecraft-frontend
            bind *:25565
            tcp-request inspect-delay 5s
            acl craft req.payload(5,16),lower -m sub mc.lench.org
            tcp-request content accept if craft
            use_backend craft if craft
          backend craft
             server craft-server 107.0.0.1:25564 check
        '';
      };
    };
}
