{
  config,
  pkgs,
  specialArgs,
  ...
}:
let
  startup =
    with pkgs;
    writeShellScriptBin "startup"
      # bash
      ''
        ${pkgs.uwsm}/bin/uwsm app -- ${hyprpaper}/bin/hyprpaper &
        ${pkgs.uwsm}/bin/uwsm app -- ${eww}/bin/eww open bar
      '';
in
{
  imports = [
    ../modules/blur.nix
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${config.stylix.image}" ];
      wallpaper = [ ",${config.stylix.image}" ];
      splash = false;
      ipc = true;
    };
  };
  wayland.windowManager.hyprland = {
    systemd.enable = true;
    settings = {
      exec-once = "${startup}/bin/startup";
      monitor =
        if specialArgs.desktop then
          [ "HDMI-A-1, 3840x2160, 0x0, 1.25" ]
        else if specialArgs.laptop then
          [ "eDP_1, 1366x768, 0x0, 1" ]
        else
          [ ", preferred, auto, 1" ];
      xwayland.force_zero_scaling = true;
      misc.disable_hyprland_logo = true;
      input = {
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
          disable_while_typing = false;
        };
      };
      general = {
        gaps_in = 5;
        gaps_out = 0;
        border_size = 0;
        layout = "dwindle";
      };

      animation = [
        "global,1,5,default"
        "workspaces,1,5,default,slidevert"
        "windows,1,5,default,slide"
      ];
      decoration.blur = {
        enabled = config.blur;
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
        #no_gaps_when_only = 1;
      };
      gestures = {
        workspace_swipe = "on";
      };
      "$mainMod" = "ALT";

      bind = [
        ", PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m region --clipboard-only"
        #"CAPS, Caps_Lock, exec, notify-send working"
        "$mainMod, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m output --clipboard-only"
        "$mainMod, H, exec, ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.ghostty}/bin/ghostty"
        "$mainMod, B, killactive,"
        "$mainMod, V, togglefloating"
        "$mainMod, S, exec, ${pkgs.uwsm}/bin/uwsm app -- $(${pkgs.wofi}/bin/wofi --show drun --define=drun-print_desktop_file=true)"
        "$mainMod, i, togglesplit,"
        "$mainMod, n, fullscreen"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set -e +5%"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set -e 5%-"
        ", XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +10%"
        ", XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -10%"
        ", XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle"

        # Move focus with mainMod + arrow keys
        "$mainMod, z, movefocus, l"
        "$mainMod, r, movefocus, d"
        "$mainMod, e, movefocus, u"
        "$mainMod, a, movefocus, r"

        # Resize windows with mainMod + SUPER + arrow keys
        "$mainMod SUPER, z, resizeactive, -25 0"
        "$mainMod SUPER, r, resizeactive, 0 25"
        "$mainMod SUPER, e, resizeactive, 0 -25"
        "$mainMod SUPER, a, resizeactive, 25 0"

        # Move windows with mainMod + shift + arrow keys
        "$mainMod SHIFT, z, movewindow, l"
        "$mainMod SHIFT, r, movewindow, d"
        "$mainMod SHIFT, e, movewindow, u"
        "$mainMod SHIFT, a, movewindow, r"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, q, workspace, 1"
        "$mainMod, g, workspace, 2"
        "$mainMod, d, workspace, 3"
        "$mainMod, f, workspace, 4"
        "$mainMod, ', workspace, 5"
        "$mainMod, z, workspace, 6"
        "$mainMod, l, workspace, 7"
        "$mainMod, u, workspace, 8"
        "$mainMod, o, workspace, 9"
        "$mainMod, y, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, q, movetoworkspace, 1"
        "$mainMod SHIFT, g, movetoworkspace, 2"
        "$mainMod SHIFT, d, movetoworkspace, 3"
        "$mainMod SHIFT, f, movetoworkspace, 4"
        "$mainMod SHIFT, ', movetoworkspace, 5"
        "$mainMod SHIFT, z, movetoworkspace, 6"
        "$mainMod SHIFT, l, movetoworkspace, 7"
        "$mainMod SHIFT, u, movetoworkspace, 8"
        "$mainMod SHIFT, o, movetoworkspace, 9"
        "$mainMod SHIFT, y, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
      ];
    };
  };
}
