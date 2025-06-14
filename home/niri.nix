{ pkgs, config, ... }:
let
  startup =
    with pkgs;
    writeShellScriptBin "startup" ''
      ${pkgs.uwsm}/bin/uwsm app -- ${swaybg}/bin/swaybg -m fill -i ${config.stylix.image} &
      ${pkgs.uwsm}/bin/uwsm app -- ${eww}/bin/eww open bar &
			${pkgs.xwayland-satellite}/bin/xwayland-satellite
    '';
in
{
  programs.niri = {
    settings = {
      spawn-at-startup = with pkgs; [
				{
					command = [ "${startup}/bin/startup" ];
				}
      ];    
			environment = {
				DISPLAY = ":0";
			};
			binds = with pkgs; with config.lib.niri.actions; {
				"XF86AudioRaiseVolume".action = spawn "${pulseaudio}/bin/pactl" "set-sink-volume" "@DEFAULT_SINK@" "+10%";
				"XF86AudioLowerVolume".action = spawn "${pulseaudio}/bin/pactl" "set-sink-volume" "@DEFAULT_SINK@" "-10%";
				"Mod+S".action = spawn "wofi";
				"Mod+F".action = spawn "ghostty";
				#"Mod+S".action = spawn "${uwsm}/bin/uwsm" "app" "--" "$(${wofi}/bin/wofi" "--define-drun-print_desktop_file=true)";
				#"Mod+F".action = spawn "${uwsm}/bin/uwsm" "app" "--" "${ghostty}";
				"Mod+Q".action = quit;
			};
    };
  };
}
