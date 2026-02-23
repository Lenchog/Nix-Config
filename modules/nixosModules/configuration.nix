{ inputs, self, ... }:
{
  flake.modules.nixos.base =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };
      fonts.fontconfig.allowBitmaps = true;
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 32 * 1024;
        }
      ];

      nix = {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-public-keys = [ "nix-key:hSWnFY8bjaxrQs/nUjirSXeNruuy1KW6fCY3cURGzfY=" ];
          secret-key-files = [ config.sops.secrets."nix-key".path ];
          auto-optimise-store = true;
          trusted-users = [ "@wheel" ];
        };
      };
      programs = {
        zsh.enable = true;
        nh.enable = true;
      };
      systemd.services.NetworkManager-wait-online.enable = false;
      services = {
        printing.enable = true;
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
      users = {
        mutableUsers = false;
        defaultUserShell = pkgs.zsh;
        users = {
          lenny = {
            hashedPasswordFile = config.sops.secrets."hashedPassword".path;
            isNormalUser = true;
            description = "Lenny";
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO+0JZwpWuhY8CMrdD7SiOHqDPWV+TBgXrjYnxB0vc/T"
            ];
            extraGroups = [
              "networkmanager"
              "wheel"
              "dialout"
              "audio"
            ];
            home = "/home/lenny";
          };
          root = {
            hashedPasswordFile = config.sops.secrets."hashedPassword".path;
          };
        };
      };
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "24.11";
    };
}
