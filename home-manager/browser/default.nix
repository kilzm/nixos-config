{
  lib,
  pkgs,
  host,
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
              name = "Nix Search";
              url = "https://search.nixos.org";
            }
            {
              name = "TUM Online";
              url = "https://campus.tum.de/tumonline";
            }
            {
              name = "TUM Moodle";
              url = "https://www.moodle.tum.de";
            }
            {
              name = "TUM Live";
              url = "https://live.rbg.tum.de";
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
        "layout.css.devPixelsPerPx" = if host == "loid" then 1.1 else 1.0;
      };

      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
        @import "firefox-gnome-theme/theme/colors/dark.css"; 
      '';

      extensions = with pkgs.firefox-addons; [
        betterttv
        purpleadblock
        vimium
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
        (buildFirefoxXpiAddon rec {
          pname = "zotero-connector";
          version = "5.0.107";
          addonId = "zotero@chnm.gmu.edu";
          url = "https://download.zotero.org/connector/firefox/release/Zotero_Connector-${version}.xpi";
          sha256 = "RuAhWGvUhkog8SxzKhRwQQwzTQLzBKlHjSsFj9e25e4=";
          meta = with lib; {
            homepage = "https://www.zotero.org";
            description = "Save references to Zotero from your web browser";
            license = licenses.gpl3;
            platforms = platforms.all;
          };
        })
        (buildFirefoxXpiAddon rec {
          pname = "adBlock plus";
          version = "3.25";
          addonId = "{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}";
          url = "https://addons.mozilla.org/firefox/downloads/file/4039476/adblock_plus-3.25.0.xpi";
          sha256 = "IQ8IjTv1kWjoO1zyJYYBnZn4DCb+pfzuwAZemMtT8nI=";
          meta = with lib; {
            mozPermissions = [ 
              "*://*.youtube.com/*"
            ];
          };
        })
      ];
    };
  };
}
