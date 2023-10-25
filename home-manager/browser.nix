{
  home = {
    sessionVariables.BROWSER = "firefox";

    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = (fetchTarball {
        url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/refs/tags/v118.tar.gz";
        sha256 = "sha256:1zn3icf73vwry9hasp5fl9lalbdy7cc95zripi9ggnrijshhfrlf";
      });
    };
  };

  programs.firefox = {
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
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.normalWidthTabs" = true;
        "gnomeTheme.tabsAsHeaderbar" = true;
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
        @import "firefox-gnome-theme/theme/colors/dark.css"; 
      '';
    };
  };
}