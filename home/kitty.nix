{ ... }:
{
  programs.kitty = {
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      font_size = 18;
    };
    shellIntegration.enableZshIntegration = true;
  };
}
