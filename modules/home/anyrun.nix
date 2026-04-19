{
  flake.modules.homeManager.anyrun =
    { pkgs, ... }:
    {
      programs.anyrun = {
        enable = true;
        config = {
          closeOnClick = true;
          showResultsImmediately = true;
          plugins = with pkgs; [
            "${anyrun}/lib/libapplications.so"
            "${anyrun}/lib/libsymbols.so"
            "${anyrun}/lib/librink.so"
            "${anyrun}/lib/libnix_run.so"
            "${anyrun}/lib/libactions.so"
            "${anyrun}/lib/libwebsearch.so"
            "${anyrun}/lib/libdictionary.so"
          ];
        };
      };
    };
}
