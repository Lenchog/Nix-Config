{ pkgs, ... }:
{
  programs.zsh = {
    dotDir = "config/zsh";
    shellAliases = {
      detnsw = "${pkgs.networkmanager}/bin/nmcli --ask con up detnsw";
      wifi = ''${pkgs.networkmanager}/bin/nmcli --ask dev wifi list | ${pkgs.coreutils}/bin/tail -n +2 | ${pkgs.gnused}/bin/sed 's/\*//g' | ${pkgs.gawk}/bin/awk '{ print $2" "$5" "$6" "$7 "%" }' | ${pkgs.fzf}/bin/fzf --bind 'enter:become(${pkgs.networkmanager}/bin/nmcli --ask dev wifi connect)' | ${pkgs.gawk}/bin/awk '{ print $1 }' '';
      ff = "${pkgs.fzf}/bin/fzf --preview '${pkgs.pistol}/bin/pistol {}' --bind 'enter:become($EDITOR {})'";
      cd = "z";
      ls = "${pkgs.lsd}/bin/lsd";
      /*
        nix = "${pkgs.nix-output-monitor}/bin/nom";
        nix-build = "${pkgs.nix-output-monitor}/bin/nom-build";
        nix-shell = "${pkgs.nix-output-monitor}/bin/nom-shell";
      */
    };
    history.path = "$HOME/.zsh_history";
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
        name = "syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "master";
          sha256 = "sha256-KRsQEDRsJdF7LGOMTZuqfbW6xdV5S38wlgdcCM98Y/Q=";
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
    initContent = ''
            ${pkgs.fastfetch}/bin/fastfetch
      			bindkey '^H' backward-kill-word
    '';
  };
  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "fd --type f";
    FZF_DEFAULT_OPTS = "--layout=reverse";
  };
}
