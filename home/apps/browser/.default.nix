{ pkgs
, lib
, inputs
, host
, ...
}:
{
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

      settings = {
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.drawInTitlebar" = true;
        "browser.compactmode.show" = true;
        "browser.startup.page" = 3;
        "svg.context-properties.content.enabled" = true;
        "xpinstall.signatures.required" = false;
      };

      extensions.packages =
        (with pkgs.firefox-addons; [
          betterttv
          purpleadblock
          ublock-origin
          pywalfox
          zotero-connector
        ])
        ++ (
          let
            inherit (pkgs.firefox-addons) buildFirefoxXpiAddon;
          in
          [
            (buildFirefoxXpiAddon rec {
              pname = "7tv";
              version = "3.1.6";
              url = "https://github.com/SevenTV/Extension/releases/download/v${version}/7tv-webextension-ext.xpi";
              sha256 = "";
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
          ]
        );
    };
  };
}
