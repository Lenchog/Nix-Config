{
  flake.modules.homeManager.firefox =
    {
      pkgs,
      config,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        profiles.lenchog = {
          search = {
            engines = {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@nix" ];
              };
              "YT" = {
                urls = [
                  {
                    template = "https://www.youtube.com/results?search_query={searchTerms}";
                  }
                ];
                icon = "https://www.youtube.com/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@yt" ];
              };

              "SearX" = {
                urls = [
                  {
                    template = "https://search.lench.org/search?q={searchTerms}";
                  }
                ];
                icon = "https://search.lench.org/favicon.ico";
                updateInterval = 24 * 60 * 60 * 1000;
                definedAliases = [ "@sx" ];
              };
            };
            force = true;
            #default = "SearX";
          };
          settings = {
            /*
              You may copy+paste this file and use it as it is.

              If you make changes to your about:config while the program is running, the
              changes will be overwritten by the user.js when the application restarts.

              To make lasting changes to preferences, you will have to edit the user.js.
            */

            /**
              **************************************************************************
               * Betterfox                                                                *
               * "Ad meliora"                                                             *
               * version: 149                                                             *
               * url: https://github.com/yokoffing/Betterfox                              *
              ***************************************************************************
            */

            /**
              **************************************************************************
               * SECTION: FASTFOX                                                         *
              ***************************************************************************
            */
            "gfx.canvas.accelerated.cache-size" = 256;

            /**
              **************************************************************************
               * SECTION: SECUREFOX                                                       *
              ***************************************************************************
            */
            /**
              TRACKING PROTECTION **
            */
            "browser.contentblocking.category" = "strict";
            "browser.download.start_downloads_in_tmp_dir" = true;
            "browser.uitour.enabled" = false;
            "privacy.globalprivacycontrol.enabled" = true;

            /**
              OCSP & CERTS / HPKP **
            */
            "security.OCSP.enabled" = 0;
            "privacy.antitracking.isolateContentScriptResources" = true;
            "security.csp.reporting.enabled" = false;

            /**
              SSL / TLS **
            */
            "security.ssl.treat_unsafe_negotiation_as_broken" = true;
            "browser.xul.error_pages.expert_bad_cert" = true;
            "security.tls.enable_0rtt_data" = false;

            /**
              DISK AVOIDANCE **
            */
            "browser.cache.disk.enable" = false;
            "browser.privatebrowsing.forceMediaMemoryCache" = true;
            "media.memory_cache_max_size" = 65536;
            "browser.sessionstore.interval" = 60000;

            /**
              SHUTDOWN & SANITIZING **
            */
            "privacy.history.custom" = true;
            "browser.privatebrowsing.resetPBM.enabled" = true;

            /**
              SPECULATIVE LOADING **
            */
            "network.http.speculative-parallel-limit" = 0;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "browser.places.speculativeConnect.enabled" = false;
            "network.prefetch-next" = false;

            /**
              SEARCH / URL BAR **
            */
            "browser.urlbar.trimHttps" = true;
            "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
            "browser.search.separatePrivateDefault.ui.enabled" = true;
            "browser.search.suggest.enabled" = false;
            "browser.urlbar.quicksuggest.enabled" = false;
            "browser.urlbar.groupLabels.enabled" = false;
            "browser.formfill.enable" = false;
            "network.IDN_show_punycode" = true;

            /**
              HTTPS-ONLY MODE **
            */
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_error_page_user_suggestions" = true;

            /**
              PASSWORDS **
            */
            "signon.formlessCapture.enabled" = false;
            "signon.privateBrowsingCapture.enabled" = false;
            "network.auth.subresource-http-auth-allow" = 1;
            "editor.truncate_user_pastes" = false;

            /**
              EXTENSIONS **
            */
            "extensions.enabledScopes" = 5;

            /**
              HEADERS / REFERERS **
            */
            "network.http.referer.XOriginTrimmingPolicy" = 2;

            /**
              CONTAINERS **
            */
            "privacy.userContext.ui.enabled" = true;

            /**
              VARIOUS **
            */
            "pdfjs.enableScripting" = false;

            /**
              SAFE BROWSING **
            */
            "browser.safebrowsing.downloads.remote.enabled" = false;

            /**
              MOZILLA **
            */
            "permissions.default.desktop-notification" = 2;
            "permissions.default.geo" = 2;
            "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
            "browser.search.update" = false;
            "permissions.manager.defaultsUrl" = "";
            "extensions.getAddons.cache.enabled" = false;

            /**
              TELEMETRY **
            */
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.server" = "data:,";
            "toolkit.telemetry.archive.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "toolkit.telemetry.shutdownPingSender.enabled" = false;
            "toolkit.telemetry.updatePing.enabled" = false;
            "toolkit.telemetry.bhrPing.enabled" = false;
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.coverage.opt-out" = true;
            "toolkit.coverage.opt-out" = true;
            "toolkit.coverage.endpoint.base" = "";
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "datareporting.usage.uploadEnabled" = false;

            /**
              EXPERIMENTS **
            */
            "app.shield.optoutstudies.enabled" = false;
            "app.normandy.enabled" = false;
            "app.normandy.api_url" = "";

            /**
              CRASH REPORTS **
            */
            "breakpad.reportURL" = "";
            "browser.tabs.crashReporting.sendReport" = false;

            /**
              **************************************************************************
               * SECTION: PESKYFOX                                                        *
              ***************************************************************************
            */
            /**
              MOZILLA UI **
            */
            "extensions.getAddons.showPane" = false;
            "extensions.htmlaboutaddons.recommendations.enabled" = false;
            "browser.discovery.enabled" = false;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
            "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
            "browser.preferences.moreFromMozilla" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.startup.homepage_override.mstone" = "ignore";
            "browser.aboutwelcome.enabled" = false;
            "browser.profiles.enabled" = true;

            /**
              THEME ADJUSTMENTS **
            */
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.compactmode.show" = true;

            /**
              AI **
            */
            "browser.ai.control.default" = "blocked";
            "browser.ml.enable" = false;
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.menu" = false;
            "browser.tabs.groups.smart.enabled" = false;
            "browser.ml.linkPreview.enabled" = false;

            /**
              FULLSCREEN NOTICE **
            */
            "full-screen-api.transition-duration.enter" = "0 0";
            "full-screen-api.transition-duration.leave" = "0 0";
            "full-screen-api.warning.timeout" = 0;

            /**
              URL BAR **
            */
            "browser.urlbar.trending.featureGate" = false;

            /**
              NEW TAB PAGE **
            */
            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;

            /**
              DOWNLOADS **
            */
            "browser.download.manager.addToRecentDocs" = false;

            /**
              PDF **
            */
            "browser.download.open_pdf_attachments_inline" = true;

            /**
              TAB BEHAVIOR **
            */
            "browser.bookmarks.openInTabClosesMenu" = false;
            "browser.menu.showViewImageInfo" = true;
            "findbar.highlightAll" = true;
            "layout.word_select.eat_space_to_next_word" = false;

            /**
              **************************************************************************
               * SECTION: SMOOTHFOX                                                       *
              ***************************************************************************
            */
            # visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
            # Enter your scrolling overrides below this line:

            /**
              **************************************************************************
               * START: MY OVERRIDES                                                      *
              ***************************************************************************
            */
            # visit https://github.com/yokoffing/Betterfox/wiki/Common-Overrides
            # visit https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening
            # Enter your personal overrides below this line:

            /**
              **************************************************************************
               * END: BETTERFOX                                                           *
              ***************************************************************************
            */

          };
          # userChrome =
          #   # css
          #   ''
          #     * {
          #     	font-family: ${config.stylix.fonts.monospace.name} !important;
          #     }
          #   '';
        };
      };
      home.file = {
        ".mozilla/firefox/lenchog/chrome" = {
          source = ./chrome;
        };
      };
    };
}
