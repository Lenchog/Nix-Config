{ inputs, ... }:
{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = with pkgs; {
        enable = true;
        defaultEditor = true;
        extraPackages = [
          inputs.nil
        ];
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
            {
              name = "python";
              auto-format = true;
              language-servers = [ "ruff" ];
            }
            {
              name = "java";
              auto-format = true;
              language-servers = [ "jdtls" ];
            }
          ];
          language-server = {
            rust-analyzer.config.check = {
              command = "clippy";
            };
            ruff = {
              command = "${pkgs.ruff}/bin/ruff";
            };
            jdtls = {
              command = "${pkgs.jdt-language-server}/bin/jdtls";
            };
            nil = {
              commands = "${inputs.nil}/bin/nil";
            };
          };
        };
      };
    };
}
