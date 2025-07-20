{
  specialArgs,
  pkgs,
  lib,
  config,
  ...
}:
with specialArgs;
{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.lix-module.nixosModules.default
      inputs.musnix.nixosModules.musnix
      inputs.nix-topology.nixosModules.default
      (
        if desktop then
          import ./archive/machines/aragorn/hardware-configuration-aragorn.nix
        else if laptop then
          import ./archive/machines/legolas/hardware-configuration-legolas.nix
        else
          { }
      )
      (if laptop then import ./modules/kanata.nix else { })
      ./modules/sops.nix
      ./modules/nh.nix

      ./modules/options.nix
      (if impermanence then import ./modules/impermanence.nix else { })
    ]
    ++ (
      if server then
        [
          inputs.disko.nixosModules.disko
          ./disko-config.nix
          ./frodo/hardware-configuration.nix
          ./frodo/minecraft.nix
          ./frodo/garf.nix
          ./frodo/searx.nix
          ./frodo/blocky.nix
          ./frodo/networking.nix
          ./frodo/grafana.nix
          ./modules/sops.nix
          ./frodo/restic.nix
          ./frodo/photoprism.nix
          ./frodo/vaultwarden.nix
          ./frodo/syncthing.nix
        ]
      else
        [ ]
    );
  fonts.fontconfig.allowBitmaps = true;
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
    direnv = {
      enable = gui;
      nix-direnv.enable = true;
    };
    gamescope = {
      enable = games;
    };
    adb.enable = laptop;
    zsh.enable = true;
    nh.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    gamemode.enable = games;
    hyprland = {
      enable = gui;
      withUWSM = true;
      xwayland.enable = true;
    };
    steam = {
      enable = games;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs =
          pkgs: with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
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
  hardware.steam-hardware.enable = games;
  powerManagement.enable = laptop;
  console = {
    earlySetup = true;
    font = "${pkgs.spleen}/share/consolefonts/spleen-16x32.psfu";
    packages = with pkgs; [ spleen ];
  };
  boot = {
    binfmt.emulatedSystems = lib.mkIf desktop [ "aarch64-linux" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = lib.mkForce null;
    };
    consoleLogLevel = 0;
    initrd = {
      verbose = false;
      kernelModules = lib.mkIf desktop [ "nvidia" ];
    };
    kernelParams = [
      "quiet"
      "udev.log_level=0"
      #(if desktop then "nvidia-drm.modeset=1" else {})
    ];
    kernelPackages = pkgs.linuxPackages_zen;
  };
  systemd.services.NetworkManager-wait-online.enable = false;
  hardware = {
    bluetooth.enable = gui;
    nvidia = lib.mkIf desktop {
      open = false;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    graphics = {
      enable = gui;
      enable32Bit = gui;
      extraPackages =
        with pkgs;
        lib.mkIf laptop [
          intel-media-driver
          intel-compute-runtime
        ];
    };
  };
  musnix.enable = true;
  services = {
    openssh = {
      enable = server;
      ports = [ 2121 ];
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    greetd = {
      enable = gui;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd '${pkgs.uwsm}/bin/uwsm start default'";
        };
      };
    };
    fail2ban.enable = server;
    getty.autologinUser = lib.mkIf vm "lenny";
    blueman.enable = gui;
    tlp.enable = laptop;
    kanata.enable = laptop;
    pipewire = {
      enable = gui;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    xserver.videoDrivers = lib.mkIf desktop [ "nvidia" ];
  };
  networking = {
    networkmanager.enable = true;
    hostName =
      if laptop then
        "legolas"
      else if server then
        "frodo"
      else if vm then
        "vm"
      else if desktop then
        "aragorn"
      else
        "computer";
  };
  users = {
    mutableUsers = false;
    defaultUserShell = lib.mkIf gui pkgs.zsh;
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
        ];
        home = "/home/lenny";
      };
      root = {
        hashedPasswordFile = config.sops.secrets."hashedPassword".path;
      };
    };
  };
  home-manager = lib.mkIf gui {
    extraSpecialArgs = specialArgs;
    users = {
      lenny = if server then import ./frodo/home-frodo.nix else ./home/home.nix;
    };
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "24.11";
  systemd.services = {
    kanata-laptop = {
      wantedBy = lib.mkForce [ "graphical.target" ];
      unitConfig.After = [ "graphical.target" ];
    };
    NetworkManager = {
      wantedBy = lib.mkForce [ "graphical.target" ];
      unitConfig.After = [ "graphical.target" ];
    };
  };
}
