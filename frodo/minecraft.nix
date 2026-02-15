{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  myJvmOpts = "-Xms5G -Xmx5G -XX:+UseCompactObjectHeaders -XX:+UseZGC";
  mods = pkgs.linkFarmFromDrvs "mods" (
    builtins.attrValues {
      # Terrain & Structures
      DungeonsAndTaverns = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/tpehi7ww/versions/bjFTHs6U/dungeons-and-taverns-v4.6.3.jar";
        sha256 = "dJd+Uvm6073rccDDmayuLZKYw9LrDH74/gkOHpL/CAc=";
      };
      BetterStrongholds = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/kidLKymU/versions/jPsIaxuA/YungsBetterStrongholds-1.21.4-Fabric-5.4.0.jar";
        sha256 = "yZ+NTrznsptLUM/RBkeKKGdp8EAtBOxyjOGgI9Oxi2Q=";
      };
      BetterMineshafts = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/HjmxVlSr/versions/ezSBs4dx/YungsBetterMineshafts-1.21.4-Fabric-5.4.0.jar";
        sha256 = "Ehn2qOCku+Pu1NaCtqr9WJZgkLcNKNh+9Q7Uk1iDldY=";
      };
      BetterDungeons = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/o1C1Dkj5/versions/JJRT74Yl/YungsBetterDungeons-1.21.4-Fabric-5.4.0.jar";
        sha256 = "eoGDcS5UVrjSsrau0m0Yuf/IR5cEE84TRz7rkPXipXk=";
      };
      BetterNetherFortresses = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Z2mXHnxP/versions/eUEnv9r3/YungsBetterNetherFortresses-1.21.4-Fabric-3.4.1.jar";
        sha256 = "IJkoGEGBBYr9ehJtGqZ7Ky2hMCIoBy1sl7oPO4gepok=";
      };
      BetterOceanMonuments = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/3dT9sgt4/versions/GArxaRHI/YungsBetterOceanMonuments-1.21.4-Fabric-4.4.0.jar";
        sha256 = "/gzMBJhZrHgx8/tJd3Flr/NXNlfurAiWewst52jjLJA=";
      };
      BetterJungleTemples = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/z9Ve58Ih/versions/dF6fSxRm/YungsBetterJungleTemples-1.21.4-Fabric-3.4.0.jar";
        sha256 = "v5tqpeyk9G2YIjTogXlbXjcvSgjjX81GDE6OSnfEmwc=";
      };
      BetterDesertTemples = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XNlO7sBv/versions/W68glo4a/YungsBetterDesertTemples-1.21.4-Fabric-4.4.0.jar";
        sha256 = "tr8BzRtCAVPRm36Ekzuy2f5dEne/86ri24WTKOESD3k=";
      };
      Bridges = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ht4BfYp6/versions/a8dqim8P/YungsBridges-1.21.4-Fabric-5.4.0.jar";
        sha256 = "CYd7re7wAZBhnoyLP4qQON4RcyEC10/jpmFNzqD3hbw=";
      };
      YungsExtras = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ZYgyPyfq/versions/qGXmN34R/YungsExtras-1.21.4-Fabric-5.4.0.jar";
        sha256 = "qsyDNL0UqA6FmAqkb795S2xc5mPycIgAenfRcR3iRDE=";
      };
      # Structory = pkgs.fetchurl {
      #   url = "https://cdn.modrinth.com/data/aKCwCJlY/versions/qm2RM1eD/Structory_1.21.x_v1.3.12.jar";
      #   sha256 = "K/R8JXsDG1Dz/mqqumow2eMKCg6ou85j4qhd7h8WRLE=";
      # };
      Terralith = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/8oi3bsk5/versions/MuJMtPGQ/Terralith_1.21.x_v2.5.8.jar";
        sha256 = "ADM6EwrDi3ucqTcACY1eAuBhK9wtNSKq2i825WAGIb8=";
      };
      Nullscape = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LPjGiSO4/versions/3fv8O3xX/Nullscape_1.21.x_v1.2.14.jar";
        sha256 = "h0nG/dplkzXlARbBjgEs34aZs3iYWcglWa8sb0Jck64=";
      };
      AmplifiedNether = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/wXiGiyGX/versions/wjOKbxcn/Amplified_Nether_1.21.x_v1.2.11.jar";
        sha256 = "sSaCHm9u/KUYk7lfVgEQy0raEoYUgLEWc5hWwYAGCvM=";
      };
      # Features
      SimpleVoiceChat = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/pl9FpaYJ/voicechat-fabric-1.21.4-2.5.26.jar";
        sha256 = "2ni2tQjMCO3jaEA1OHXoonZpGqHGVlY/9rzVsijrxVA=";
      };
      DoubleDoors = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/JrvR9OHr/versions/oqgL7jds/doubledoors-1.21.4-7.0.jar";
        sha256 = "SsUhX9GTZn9cg4L5Y/IHfvJi/wBjTJ91vkp5ri9QwUg=";
      };
      Appleskin = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/cHQjeYVS/appleskin-fabric-mc1.21.3-3.0.6.jar";
        sha256 = "+PYRdG34jxc3tip2YVo2b0KjMXMOoW25fFLW9VQMWKs=";
      };
      ViaVersion = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/P1OZGk5p/versions/sVahWBKF/ViaVersion-5.5.1.jar";
        sha256 = "Iit8Jo0CErea7UWduAEucBRZfI70QzcSIVHl9uC7KGg=";
      };
      DeathCount = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/JaEZg1D1/versions/YQjXpK5d/death-count-1.0.jar";
        sha256 = "RmmyvPxZoDDggdPUmF5roWjeI30hSuq1PdZeq0L2HPA=";
      };

      OpenPartiesAndClaims = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gF3BGWvG/versions/XWAUhwUo/open-parties-and-claims-fabric-1.21.4-0.25.8.jar";
        sha256 = "DA9LbiwwUUshBxVimVl2pgqP8KN2vLyZ+l7U7vZf+Sw=";
      };
      ViveCraft = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/wGoQDPN5/versions/GdTUTu77/vivecraft-1.21.4-1.2.5-fabric.jar";
        sha256 = "KESfS7od8CSyeWTajzB9x6CCDAvFiZOvviZE8JV2xpc=";
      };
      HorseBuff = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/IrrG0G8l/versions/wNa4026m/HorseBuff-1.21.4-2.2.1.jar";
        sha256 = "GklKdsoaNrUsgEmI/B4t3xdWKscANn86ew+58zjO51I=";
      };
      CropsLoveRain = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/cRci7UZp/versions/JT0fNDm0/Crops-Love-Rain-2.4.1.jar";
        sha256 = "YLybl203ESdvZ31C/vMTBDTFKZCguevU86lBbKsTofM=";
      };
      Discord = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/rbJ7eS5V/versions/hd62ja8J/dcintegration-fabric-MC1.21.3-3.1.0.1.jar";
        sha256 = "5Us8Ig8Nwv9zFLQx8X/C7cTz/O0uTDjeztYMAXBWK0Q=";
      };
      Trample = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ovK1G5ym/versions/gUmayHoY/no-crop-trample-ALT1.jar";
        sha256 = "RzsD5iL7S8XUywVDl1+4AY82xGIL87anf4Y1kpukphY=";
      };
      FabricExporter = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/dbVXHSlv/versions/phBInZSv/fabricexporter-1.0.14.jar";
        sha256 = "xQqW4LQ/hddDKZWCNwPXJgP2L2up9oHJN64pGbSzIdM=";
      };
      EasyWhitelist = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LODybUe5/versions/9OoxSFQz/easywhitelist-1.1.0.jar";
        sha256 = "gon45yHrNvgbwTt7bK1N9r0wpR91j5ynAlF+YQzwzQA=";
      };
      LenientDeath = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Bfi1KBJV/versions/rxsQ1aP9/lenientdeath-1.2.5%2B1.21.2.jar";
        sha256 = "KUveYV7trHhbf5dyeXvSyDcqnZOfX0sOC4S8NYepzhU=";
      };
      # Anti cheat
      EasyAuth = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/aZj58GfX/versions/ZAl3Kcyc/easyauth-mc1.21.2-3.1.10.jar";
        sha256 = "qHJipM0RJn6C9G0ZcgRS+izh9xeN8gC6nFkx0pLx5O0=";
      };
      AntiXRay = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/sml2FMaA/versions/dwTZzfS4/antixray-fabric-1.4.9%2B1.21.4.jar";
        sha256 = "zv1giJdIOZSRnvxo4fLulT7UkTnDspE4CMNpRmn7rSY=";
      };
      SecureSeed = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/mj5Qr8TC/versions/WzYSWs2b/secure-seed-reborn-1.0.1.jar";
        sha256 = "i9jNhJS6NiGZec5vUG2BP4ZrehVkoLQmQPXHlAhVkrQ=";
      };
      SeedGuard = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/7e8ji5y2/versions/uLrh8ZKV/seedguard%2B1.20.5-rc3-1.0.1.jar";
        sha256 = "pDPYeWXFEWkJUG5cyYqc4plGckJccOvdoiE6rI3xi74=";
      };
      Vanish = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/UL4bJFDY/versions/sOVWUHwB/vanish-1.5.12%2B1.21.4.jar";
        sha256 = "kDswxMVQv0mWfA2VEOMEGlaFZZzKjIH2jqO4i5OEt7g=";
      };
      InvView = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/jrDKjZP7/versions/LNGVFn7g/InvView-1.4.15-1.20.5%2B.jar";
        sha256 = "fsEUjewyHKVg/0RJcpTdl0ClWSRj3ApU8Qv+AxIFZJE=";
      };
      Ledger = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LVN9ygNV/versions/pzDwE16E/ledger-1.3.7-fix.jar";
        sha256 = "UIhf8lO639dJdlYeyDUTRMcGblZ8TX+k8WZR9fHClu8=";
      };

      # Performance
      Lithium = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/kLc5Oxr4/lithium-fabric-0.14.8%2Bmc1.21.4.jar";
        sha256 = "tRIF9xDNCcY5scktZLxSG6bZD/pej0GVHspeo2kSFT0=";
      };
      Chunky = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fALzjamp/versions/VkAgASL1/Chunky-Fabric-1.4.27.jar";
        sha256 = "A8kKcLIzQWvZZziUm+kJ0eytrHQ/fBVZQ18uQXN9Qf0=";
      };
      FerriteCore = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/IPM0JlHd/ferritecore-7.1.1-fabric.jar";
        sha256 = "sha256-DdXpIDVSAk445zoPW0aoLrZvAxiyMonGhCsmhmMnSnk=";
      };
      Krypton = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/Acz3ttTp/krypton-0.2.8.jar";
        sha256 = "lPGVgZsk5dpk7/3J2hXN2Eg2zHXo/w/QmLq2vC9J4/4=";
      };
      ModernFix = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nmDcB62a/versions/ZGxQddYr/modernfix-fabric-5.20.3%2Bmc1.21.4.jar";
        sha256 = "zrQ15ShzUtw1Xty1yxxO/n8xYofpaATSF9ewEeqE/d4=";
      };
      C2ME = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/VSNURh3q/versions/yGX4O0YU/c2me-fabric-mc1.21.4-0.3.1.1.0.jar";
        sha256 = "eeKOKJVyKMIbd12/vRItWNMluCws7/3TikGmUwfd2/A=";
      };
      Noisium = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/9NHdQfkN/noisium-fabric-2.5.0%2Bmc1.21.4.jar";
        sha256 = "JmSbfF3IDaC1BifR8WaKFCpam6nHlBWQzVryDR6Wvto=";
      };
      Spark = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/l6YH9Als/versions/X2sypdTL/spark-1.10.121-fabric.jar";
        sha256 = "E1BDAk8b1YBuhdqLK98Vh4xVmL99qs5dEwI2/wCbt28=";
      };
      ServerCore = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/4WWQxlQP/versions/uJYh4tBK/servercore-fabric-1.5.8%2B1.21.4.jar";
        sha256 = "fC6fTqt88WkGrpU8caWno9TapUYHnh8D06A6dzS2hVE=";
      };
      # dependencies
      Fabric = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/ZNwYCTsk/fabric-api-0.118.0%2B1.21.4.jar";
        sha256 = "EDrLCs4eCeI4e8oe03vLVlYEESwRlhneCQ5vrjswPFM=";
      };
      ViaFabric = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/YlKdE5VK/versions/Niu0KrUK/ViaFabric-0.4.17%2B91-main.jar";
        sha256 = "gJQYHj9O2IZ7iKkZcLbuDiEmGIogHipFmJR/8b9lpPM=";
      };
      YungsApi = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ua7DFN59/versions/U4m2SXEP/YungsApi-1.21.4-Fabric-5.4.0.jar";
        sha256 = "Wpcr13WfPptga4V4yySqVPcA/fAO/e67azHVSUtFOeI=";
      };
      Collective = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/I5jY2gQ2/collective-1.21.4-8.3.jar";
        sha256 = "mIeBy9zRcRUZlskk3BDSA518tyLQ04FwCRpDsboMhGo=";
      };
      FabricLanguageKotlin = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/LcgnDDmT/fabric-language-kotlin-1.13.7%2Bkotlin.2.2.21.jar";
        sha256 = "d5UZY+3V19N+5PF0431GqHHkW5c0JvO0nWclyBm0uPI=";
      };
      ForgeConfigAPIPort = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ohNO6lps/versions/lTrPTmMK/ForgeConfigAPIPort-v21.4.1-1.21.4-Fabric.jar";
        sha256 = "Hh8uPw8DhbxwXDyrnvcaUyriKEC/ab9x1Kulj1lFbdY=";
      };
      ClothConfig = pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9s6osm5g/versions/TJ6o2sr4/cloth-config-17.0.144-fabric.jar";
        sha256 = "H9oMSonU8HXlGz61VwpJEocGVtJS2AbqMJHSu8Bngeo=";
      };
    }
  );
in
{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  services.minecraft-servers = {
    enable = true;
    eula = true;
    dataDir = "/var/lib/minecraft";
    servers = {
      gtnh = rec {
        enable = true;
        package = pkgs.callPackage ./gtnh.nix { };
        files = {
          config = "${package}/lib/config";
          serverutilities = "${package}/lib/serverutilities";
        };
        jvmOpts = myJvmOpts;
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
      season-4 = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_21_4;
        serverProperties = {
          server-port = 25564;
          difficulty = "hard";
          motd = "Season 4";
          max-world-size = 2500;
          online-mode = false;
          white-list = true;
          enable-command-block = true;
        };
        symlinks."mods" = mods;
        jvmOpts = myJvmOpts;
      };
    };
  };
  services.haproxy = {
    enable = true;
    config = ''
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
         server craft-server 127.0.0.1:25564 check
    '';
  };
}
