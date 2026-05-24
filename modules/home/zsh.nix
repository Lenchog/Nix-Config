{
  flake.modules.homeManager.zsh =
    { pkgs, ... }:
    {
      programs.zsh = {
        enable = true;
        history.path = "$HOME/.zsh_history";
        shellAliases = {
          ff = "${pkgs.fzf}/bin/fzf --preview '${pkgs.pistol}/bin/pistol {}' --bind 'enter:become($EDITOR {})'";
          cd = "z";
          ls = "${pkgs.lsd}/bin/lsd";
        };
        plugins = [
          {
            name = "zsh-autosuggestions";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-autosuggestions";
              rev = "v0.4.0";
              sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
            };
          }
          {
            name = "zsh-patina";
            file = "zsh-patina.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "michael-kraemer";
              repo = "zsh-patina";
              rev = "master";
              sha256 = "";
            };
          }
          {
            name = "zsh-vi-mode";
            src = pkgs.fetchFromGitHub {
              owner = "jeffreytse";
              repo = "zsh-vi-mode";
              rev = "v0.11.0";
              sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
            };
          }
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "powerlevel10k-config";
            src = ./.;
            file = "p10k.zsh";
          }
        ];
        initContent = with pkgs; ''
          ${fastfetch}/bin/fastfetch
           bindkey '^H' backward-kill-word
        '';
      };
    };
}
