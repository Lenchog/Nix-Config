{ ... }:
{
  programs.zellij = {
    enableZshIntegration = true;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
      theme = "catppuccin-mocha";
    };
  };
}
