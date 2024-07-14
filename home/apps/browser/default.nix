{ pkgs, lib, inputs, host, ... }: {
  nixpkgs.overlays = [ (import "${inputs.rycee-nur}/overlay.nix") ];

  home = {
    sessionVariables = {
      BROWSER = "firefox";
      MOZ_REQURE_SIGNING = "0";
    };

    packages = with pkgs; [
      pywalfox-native
    ];
  };

  programs.firefox = {
    package = pkgs.firefox-wayland;
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      SearchBar = "unified";
    };

    profiles.kilianm = {
      name = "kilianm";
      bookmarks = [{
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
      }];

      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "browser.compactmode.show" = true;
        "browser.startup.page" = 3;
        "svg.context-properties.content.enabled" = true;
        "xpinstall.signatures.required" = false;
      };

      extensions = (with pkgs.firefox-addons; [
        betterttv
        purpleadblock
        ublock-origin
        pywalfox
      ]) ++ (
        let
          inherit (pkgs.firefox-addons) buildFirefoxXpiAddon;
        in
        [
          (buildFirefoxXpiAddon {
            pname = "7tv";
            version = "3.0.10";
            url = "https://extension.7tv.gg/v3.0.10.1000/ext.xpi";
            sha256 = "sha256-dZyjFayvnLebSZHjMTTQFjcsxxpmc1aL5q17mLF3kG8=";
            addonId = "moz-addon@7tv.app";
            meta = {
              mozPermissions = [
                "*://*.twitch.tv/*"
                "*://*.youtube.com/*"
                "*://*.7tv.app/*"
                "*://*.7tv.io/*"
              ];
              license = lib.licenses.asl20;
            };
          })
          (buildFirefoxXpiAddon rec {
            pname = "zotero-connector";
            version = "5.0.107";
            addonId = "zotero@chnm.gmu.edu";
            url =
              "https://download.zotero.org/connector/firefox/release/Zotero_Connector-${version}.xpi";
            sha256 = "RuAhWGvUhkog8SxzKhRwQQwzTQLzBKlHjSsFj9e25e4=";
            meta = with lib; {
              homepage = "https://www.zotero.org";
              description = "Save references to Zotero from your web browser";
              license = licenses.gpl3;
              platforms = platforms.all;
            };
          })
        ]
      );
    };
  };
}
