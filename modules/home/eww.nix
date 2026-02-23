{
  flake.modules.homeManager.eww =
    { pkgs, config, ... }:
    let
      audio =
        pkgs.writeShellScriptBin "audio"
          # bash
          ''
            ${pkgs.pamixer}/bin/pamixer --get-volume;
            ${pkgs.pulseaudio}/bin/pactl subscribe \
            	| grep --line-buffered "Event 'change' on sink " \
            	| while read -r evt;
            	do ${pkgs.pamixer}/bin/pamixer --get-volume | cut -d " " -f1;
            done
          '';
    in
    {
      home.packages = [ pkgs.eww ];
      xdg.configFile."eww/eww.yuck".text =
        # yuck
        ''
          (defwidget bar [screen]
          	(centerbox :orientation "v"
          		(box :class "segment-top"
          				 :valign "start"
          			(top :screen screen))
          		(box :valign "center"
          				 :class "middle"
          			(middle :screen screen))
          		(box :valign "end"
          				 :class "segment-bottom"
          			(bottom :screen screen))))

          (defwidget top [screen]
          		(box :class "metric" :style "color: #${config.lib.stylix.colors.base09}"(date)))

          (defwidget middle [] (time))
          (defwidget time []
          	(box :orientation "v"
          			 :class "time"
          			 :style "color: #${config.lib.stylix.colors.base0C}"
          		hour min))


          (defwidget metric [icon ?font-size]
          	(box :class "metric"
          			 :orientation "v"
          		(label :class "metric-icon"
          					 :style {font-size != "" ? "font-size: ''${font-size}rem;" : ""}
          					 :text icon)
          		(children)))

          (defwidget bottom [screen]
          	(box :orientation "v"
          			 :valign "end"
          			 :space-evenly true
          			 :spacing "5"

          		;(metric :icon "󰎆" :font-size 1 (music-button))

          		(volume)

          		(battery)))

          		;(metric :icon ""
          		;        :font-size 0.8
          		;  "''${round((1 - (EWW_DISK["/"].free / EWW_DISK["/"].total)) * 100, 0)}%")

          		;(metric :icon "󰍛" "''${round(EWW_RAM.used_mem_perc, 0)}%")

          		;(metric :icon "" "''${round(EWW_CPU.avg, 0)}%")


          (defwidget music-button []
          	(button :onclick "playerctl play-pause"
          		"''${music_data == "" ? "⏸" : music_data.status == "Playing" ? "⏸" : "▶"}"))

          (defwidget battery []
          			(box :class "volume-metric"
          					 :orientation "v"
          					 :space-evenly false
          					 :valign "fill"
          					 :vexpand false
          				(scale :orientation "h"
          							 :min 0
          							 :max 100
          							 :value "''${round(EWW_BATTERY.BAT0.capacity, 0)}")
          					(box :orientation "v"
          							 :valign "fill"
          							 :vexpand true
          					(button
          						(label :style "font-size: 1.2em; color: #${config.lib.stylix.colors.base06}"
          									 :text "󰁹"))
          							 "''${round(EWW_BATTERY.BAT0.capacity,0)}%")))


          (defwidget volume []
          	(box :class "volume-metric"
          			 :orientation "v"
          			 :space-evenly false
          			 :valign "fill"
          			 :vexpand false
          		(scale :orientation "h"
          					 :min 0
          					 :max 100
          					 :onchange "${pkgs.pamixer}/bin/pamixer --set-volume $(echo {} | sed 's/\\..*//g')"
          					 :value volume)
          		(eventbox :onscroll "if [ '{}' == 'up' ]; then ${pkgs.pamixer}/bin/pamixer -i 5; else ${pkgs.pamixer}/bin/pamixer -d 5; fi"
          							:vexpand true
          							:valign "fill"
          			(box :orientation "v"
          					 :valign "fill"
          					 :vexpand true
          		(button
                  (label :style "font-size: 1.2em; color: #${config.lib.stylix.colors.base0B}"
                         :text "󰕾"))
          						 "''${volume}%"))))

          (defwidget large-sym [sym]
          	(label :class "metric-icon large-symbol" :text sym))

          (defwidget date []
          	(box :orientation "v"
          			 :halign "center"
          		day_word day month year))

          (defvar audio_sink "")

          (deflisten volume :initial "0" "${audio}/bin/audio volume")

          (deflisten music_data
          	:initial `{"status": ""}`
          	`
          	playerctl          metadata --format '{ "status": "{{status}}", "artist": "{{artist}}", "title": "{{title}}"}' || echo '{"status": ""}';
          	# playerctl --follow metadata --format '{ "status": "{{status}}", "artist": "{{artist}}", "title": "{{title}}"}'
          	`)

          (defpoll hour :interval "1s" "date +%H")
          (defpoll min  :interval "1s" "date +%M")
          (defpoll sec  :interval "1s" "date +%S")

          (defpoll day_word :interval "10m" "date +%a | tr [:upper:] [:lower:]")
          (defpoll day      :interval "10m" "date +%d")
          (defpoll month    :interval "1h"  "date +%m")
          (defpoll year     :interval "1h"  "date +%y")

          	(defwindow bar
          		:monitor 0
          		:stacking "fg"
          		:geometry (geometry :x 0 :y 0 :width "40px" :height "100%" :anchor "center left")
          		:exclusive true
          		(bar :screen 1))

          ;(defwidget music-popup []
          ;(if-else :cond {music_data.status == "Stopped" || music_data.status == ""}
          ;"No music playing"
          ;(box :orientation "h"
          ;:valign "fill"
          ;:space-evenly false
          ;:spacing 10
          ;(button :onclick "playerctl previous" "⏮")
          ;"''${music_data.artist} - $\{music_data.title}"
          ;(button :onclick "playerctl next" "⏭"))))

          ;(defwindow music_popup
          ;:monitor 1
          ;:anchor "bottom left"
          ;:geometry (geometry :x "30px" :y "10px" :height "65px")
          ;(music-popup))
        '';
      xdg.configFile."eww/eww.scss".text =
        # scss
        ''
          * {
          	all: unset;
          	font-family: ${config.stylix.fonts.monospace.name};
          }

          window {
          	background: #${config.lib.stylix.colors.base00};
          	color: #${config.lib.stylix.colors.base05};
          	font-size: 14px;

          	& > * {
          		margin: 3px;
          	}
          }

          .segment-top {
          	margin-top: 10px;
          }

          .segment-bottom {
          	margin-bottom: 10px;
          }

          .volume-metric {
          	background-color: #${config.lib.stylix.colors.base01};
          	color: #${config.lib.stylix.colors.base05};
          	padding: 0;

          	.volume-top > scale {
          		margin-bottom: 5px;
          	}

          	slider {
          		all: unset;
          	}

          	scale trough highlight {
          		all: unset;
          		background-color: #${config.lib.stylix.colors.base05};
          		border-bottom-right-radius: 5px;
          	}
          	scale trough {
          		all: unset;
          		background-color: #${config.lib.stylix.colors.base03};
          		min-width: 34px;
          		min-height: 2px;
          	}
          }

          .large-symbol {
          	font-size: 0.8em;
          }

          .metric {
          	background-color: #${config.lib.stylix.colors.base01};
          	padding: 5px 2px;
          }
          .metric-icon {
          	font-size: 0.7em;
          }

          .time {
          	padding-top: 7px;
          	padding-bottom: 7px;
          	color: #${config.lib.stylix.colors.base05};
          }
        '';
    };
}
