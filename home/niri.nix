{ pkgs, ... }:
let
  startup =
    with pkgs;
    writeShellScriptBin "startup" ''
      ${pkgs.uwsm}/bin/uwsm app -- ${hyprpaper}/bin/hyprpaper
      ${pkgs.uwsm}/bin/uwsm app -- ${eww}/bin/eww open bar
    '';
in
{
  programs.niri = {
    settings = {
      spawn-at-startup = with pkgs; [
        #"${hyprpaper}/bin/hyprpaper"
        {
          command = [
            "${eww}/bin/eww"
            "open"
            "bar"
          ];
        }
      ];
    };
  };
}
