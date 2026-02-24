{ config, inputs, ... }:
{
  flake.modules.homeManager.niri =
    { pkgs, config, ... }:
    let
      startup =
        with pkgs;
        writeShellScriptBin "startup" ''
          ${uwsm}/bin/uwsm app -- ${swaybg}/bin/swaybg -m fill -i ${config.stylix.image} &
          ${uwsm}/bin/uwsm app -- ${eww}/bin/eww open bar
        '';
    in
    {
      imports = [ inputs.niri.homeModules.niri ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];
      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
        settings = {
          prefer-no-csd = true;
          spawn-at-startup = [ { command = [ "${startup}/bin/startup" ]; } ];
          animations = {
            slowdown = 0.5;
          };
          layout = {
            gaps = 0;
            focus-ring = {
              enable = false;
            };
          };
          binds =
            with pkgs;
            with config.lib.niri.actions;
            let
              sh = spawn "sh" "-c";
            in
            {
              "XF86AudioRaiseVolume".action = sh "${wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 0.1+";
              "XF86AudioMute".action = sh "${wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";
              "XF86AudioMicMute".action = sh "${wireplumber}/bin/wpctl set-mute @DEFAULT_SOURCE@ toggle";
              "XF86AudioLowerVolume".action = sh "${wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 0.1-";
              "XF86MonBrightnessUp".action = sh "${brightnessctl}/bin/brightnessctl set +10%";
              "XF86MonBrightnessDown".action = sh "${brightnessctl}/bin/brightnessctl set 10%-";
              "Mod+S".action =
                sh "${uwsm}/bin/uwsm app -- $(${wofi}/bin/wofi --define-drun-print_desktop_file=true)";
              "Mod+F".action = sh "${uwsm}/bin/uwsm app -- ${foot}/bin/footclient";
              "Mod+Q".action = close-window;
              "Mod+A".action = fullscreen-window;
              "Mod+Shift+Q".action = quit;
              "Mod+H".action = focus-column-left;
              "Mod+J".action = focus-window-down;
              "Mod+K".action = focus-window-up;
              "Mod+L".action = focus-column-right;
              "Mod+Shift+H".action = move-column-left;
              "Mod+Shift+J".action = move-window-down;
              "Mod+Shift+K".action = move-window-up;
              "Mod+Shift+L".action = move-column-right;
            };
        };
      };
    };
}
