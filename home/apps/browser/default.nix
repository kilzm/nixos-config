{
  pkgs,
  lib,
  inputs,
  ...
}: {
  nixpkgs.overlays = [(import "${inputs.rycee-nur}/overlay.nix")];

  home = {
    sessionVariables = {
      BROWSER = "zen";
      MOZ_LEGACY_PROFILES=1;
    };
  };

  programs.zen-browser = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
    };

    profiles.kilianm = {
      name = "kilianm";

      search = {
        force = true;
        default = "ddg";
      };

      settings = {
        "zen.urlbar.replace-newtab" = false;
        "xpinstall.signatures.required" = false;
      };

      extensions = {
        force = true;
        packages = with pkgs.firefox-addons; [
          betterttv
          purpleadblock
          ublock-origin
          zotero-connector
          seventv
        ];
      };
    };
  };
}
