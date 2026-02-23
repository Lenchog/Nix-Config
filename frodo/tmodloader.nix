{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  version = "v2025.10.3.1";
in
{
  imports = [ inputs.nix-tmodloader.nixosModules.tmodloader ];
  nixpkgs.overlays = [
    inputs.nix-tmodloader.overlay
    (final: prev: {
      tmodloader-server = prev.tmodloader-server.overrideAttrs (oldAttrs: {
        inherit version;
        src = pkgs.fetchurl {
          url = "https://github.com/tModLoader/tModLoader/releases/download/${version}/tModLoader.zip";
          sha256 = "J9Dn82wOfxqhcjfjmC12zx87RPBPinWQFN4fd3EXwVU=";
        };
      });
    })
  ];
  services.tmodloader = {
    enable = false;
    servers.ieor = {
      enable = true;
      autoStart = true;
      password = "evilchester19";
      world = /var/lib/tmodloader/ieor/Worlds/Infernal_Eclipse.wld;
      noupnp = true;
      install = [
        3021379176 # Achievment Fix
        2815010161 # Shared World Map
        2827634634 # Where's My Items
        2619954303 # Recipe Browser
        2687866031 # Census
        2827999994 # DPSExtreme
        2669644269 # Boss Checklist
        2822937879 # Boss Stats
        3456517686 # IEoR
        2824688072 # Calamity
        3459129920 # Infernum
        2864843929 # Consolaria
        2843112914 # SotS
        2909886416 # Thorium
        3427152309 # Reveangance+
        3158254975 # Better Caves
        3017370769 # Better Fishing
        2824688266 # Calamity Music
        2836588773 # Coloured Calamity Relics
        3458992153 # Infernum Music
        3417899539 # Calamity Boss Resyncer
        3361139643 # Calamity Expert Accessories
        2860270524 # Ranger Expansion
        2824688804 # Vanities
        3241967932 # CalHunt
        3361303564 # CalHunt Expert Accessory
        2995193002 # WotG
        3361351961 # Catalyst Expert Accessory
        2838015851 # Catalyst
        3028584450 # Clamity
        3161277410 # Clamity Music
        3277076046 # Draedon's Expansion
        2958674071 # Heartbeataria
        3013189983 # Hypnos
        2563309347 # Magic Storage
        3164029586 # MCA
        2939093580 # Orchid Mineshaft
        3114886209 # Ragnarok
        3453353275 # Recipe Browser + Magic Storage
        2790924965 # Structure Helper
        2785100219 # Subworld Library
        2974503494 # More Pylons
        2563098343 # Team Spectate
        2828370879 # Shop Expander
        3070717963 # Helheim
        3142064272 # Cal Bard + Healer
        3436582116 # Thorium Loot Tweaks
        3404410551 # SotS Thorium classes
        3556808030 # Infernum SotS WorldGen
        3351534238 # Cal Crossmod Vulnerabilities
        2816188633 # Vanilla Cal Music
        3452171528 # WHummus' Balancing
        3485175010 # IEoR Weapon DLC
        3535746309 # Thrower Unification
        3168580963 # You
        3030483105 # Enchanted Moons
        2793782057 # Colored Damage Types
        2908170107 # absoluteAquarian Utils
        3222493606 # Luminance
        3446119263 # tPackBuilder
        3207928342 # Frenetic
      ];
    };
  };
}
