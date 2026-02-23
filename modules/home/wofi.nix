{
  flake.modules.homeManager.wofi =
    {
      config,
      lib,
      ...
    }:
    {
      programs.wofi = {
        enable = true;
        settings = {
          insensitive = true;
          allow_images = true;
          mode = "drun";
          width = 400;
          height = 500;
          location = "center";
          #matching = "fuzzy";
          prompt = "";
          orientation = "vertical";
          image_size = 24;
          #idk what these do
          halign = "fill";
          no_actions = true;
          #allow_markup = true;
          filter_rate = 100;
          allow_markup = true;
        };
        style =
          with config.lib.stylix.colors;
          lib.mkForce
            # css
            ''
              * {
              		font-family: ${config.stylix.fonts.monospace.name}, monospace;
              		font-size: 24px;
               }

               /* Window */
               window {
              		margin: 0px;
              		padding: 10px;
              		border: 1px #${base07};
              		border-radius: 5px;
              		background-color: #${base00};
              		//animation: slideIn 0.5s ease-in-out both;
               }

               /* Slide In */
               @keyframes slideIn {
              		0% {
              			 opacity: 0;
              		}

              		100% {
              			 opacity: 1;
              		}
               }

               /* Inner Box */
               #inner-box {
              		margin: 5px;
              		padding: 10px;
              		border: none;
              		background: #${base00};
              		animation: fadeIn 0.5s ease-in-out both;
               }

               /* Fade In */
               @keyframes fadeIn {
              		0% {
              			 opacity: 0;
              		}

              		100% {
              			 opacity: 1;
              		}
               }

               /* Outer Box */
               #outer-box {
              		margin: 5px;
              		padding: 10px;
              		border: none;
              		background-color: #${base00};
               }

               /* Scroll */
               #scroll {
              		margin: 0px;
              		padding: 10px;
              		border: none;
               }

               /* Input */
               #input {
              		margin: 5px;
              		padding: 10px;
              		border: none;
              		color: #${base05};
              		background-color: #${base01};
              		animation: fadeIn 0.5s ease-in-out both;
               }

               /* Text */
               #text:selected {
              	color: #${base05};
               }
               #text {
              		margin: 5px;
              		padding: 10px;
              		border: none;
              		color: #${base05};
              		animation: fadeIn 0.5s ease-in-out both;
               }

               /* Selected Entry */
               #entry:selected {
              	 background: linear-gradient(90deg, #${base05}, #${base07});
              	 border-radius: 5px;
               }

               #entry:selected #text {
              		color: #${base00};
               }
            '';
      };
    };
}
