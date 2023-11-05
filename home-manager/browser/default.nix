{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  home = {
    sessionVariables.BROWSER = "firefox";
    sessionVariables.MOZ_REQURE_SIGNING = "0";

    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = (fetchTarball {
        url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/refs/tags/v118.tar.gz";
        sha256 = "sha256:1zn3icf73vwry9hasp5fl9lalbdy7cc95zripi9ggnrijshhfrlf";
      });
    };
  };

  programs.firefox = {
    package = pkgs.firefox-wayland;
    enable = true;
    profiles.kilianm = {
      name = "kilianm";
      bookmarks = [
        {
          toolbar = true;
          name = "Sites";
          bookmarks = [
            {
              name = "GitHub";
              url = "https://www.github.com";
            }
            {
              name = "YouTube";
              url = "https://www.youtube.com";
            }
            {
              name = "Twitch";
              url = "https://www.twitch.tv";
            }
            {
              name = "LMU Mail";
              url = "https://mailbox.portal.uni-muenchen.de/webmail/init/init/Init.html";
            }
            {
              name = "Nix Search";
              url = "https://search.nixos.org";
            }
          ];
        }
      ];

      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "browser.compactmode.show" = true;
        "browser.startup.page" = 3;
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
        "xpinstall.signatures.required" = false;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
        @import "firefox-gnome-theme/theme/colors/dark.css"; 
      '';

      extensions = let
        buildFirefoxXpiAddon = pkgs.firefox-addons.buildFirefoxXpiAddon;
      in with pkgs.firefox-addons; [
        betterttv
        (buildFirefoxXpiAddon rec {
          pname = "7tv";
          version = "3.0.10";
          url = "https://extension.7tv.gg/v3.0.10.1000/ext.xpi";
          sha256 = "sha256-dZyjFayvnLebSZHjMTTQFjcsxxpmc1aL5q17mLF3kG8=";
          addonId = "moz-addon@7tv.app";
          meta = with lib; {
            mozPermissions = [ 
              "*://*.twitch.tv/*"
              "*://*.youtube.com/*"
              "*://*.7tv.app/*"
              "*://*.7tv.io/*"
            ];
            license = licenses.asl20;
          };
        })
      ];
    };
  };
}
