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
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        # useGlobalPkgs = true;
        # extraSpecialArgs.hasGlobalPkgs = true;
        users.lenny.imports = with self.modules.homeManager; [
          base
          packages
          eww
          fastfetch
          firefox
          foot
          git
          helix
          lf
          niri
          mako
          stylix
          wofi
          zoxide
          zsh
        ];
      };
      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };
      networking.useDHCP = lib.mkDefault true;
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
      time.timeZone = "Australia/Sydney";
      i18n.defaultLocale = "en_AU.UTF-8";
      programs = {
        ssh.extraConfig = ''
          Host frodo
            Hostname lench.org
            Port 2121
            User lenny
            IdentityFile ${config.sops.secrets."ssh-private-key".path}
        '';
        zsh.enable = true;
        nh.enable = true;
      };
      console = {
        earlySetup = true;
        font = "${pkgs.spleen}/share/consolefonts/spleen-16x32.psfu";
        packages = with pkgs; [ spleen ];
      };
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = lib.mkForce null;
        };
        consoleLogLevel = 0;
        initrd = {
          verbose = false;
          availableKernelModules = [
            "xhci_pci"
            "nvme"
          ];
        };
        kernelParams = [
          "quiet"
          "udev.log_level=0"
        ];
        kernelPackages = pkgs.linuxPackages_zen;
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
      networking = {
        networkmanager.enable = true;
        nameservers = [ "192.168.1.42" ];
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
