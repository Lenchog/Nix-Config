{ inputs, ... }:
{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = with pkgs; {
        enable = true;
        defaultEditor = true;
        extraPackages = [ inputs.nil ];
        settings = {
          theme = lib.mkForce "t_catppuccin_mocha";
          editor = {
            line-number = "relative";

            lsp = {
              display-messages = true;
            };
            end-of-line-diagnostics = "hint";
            inline-diagnostics.cursor-line = "warning";
          };
          keys.insert = {
            C-backspace = "delete_word_backward";
          };
        };
        themes = {
          t_catppuccin_mocha = {
            inherits = "catppuccin_mocha";
            "ui.background" = { };
          };
        };
        languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = "${nixfmt}/bin/nixfmt";
              language-servers = [ "nil" ];
            }
            {
              name = "rust";
              auto-format = true;
              language-servers = [ "rust-analyzer" ];
            }
          ];
          language-server.rust-analyzer.config.check = {
            command = "clippy";
          };
          language-server.nil = {
            commands = "${inputs.nil}/bin/nil";
            config = { };
          };
        };
      };
    };
}
