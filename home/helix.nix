{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  programs.helix = {
    settings = {
      theme = lib.mkForce "catppuccin_mocha";
      editor = {
        line-number = "relative";
      };
    };
    languages = {
      language = with pkgs; [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${nixfmt}/bin/nixfmt";
          language-servers = [ nil ];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = "${cargo}/bin/cargo fmt";
          language-servers = [ rust-analyzer ];
        }
      ];
      language-server = {
        rust-analyzer = {
          commands = "rust-analyzer";
          config = { };
        };
        nil = {
          commands = "${inputs.nil}/bin/nil";
          config = { };
        };
      };
    };
  };
}
