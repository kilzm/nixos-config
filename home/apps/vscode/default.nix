{ pkgs, config, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions;
      [
        vscodevim.vim
        jdinhlife.gruvbox
        arcticicestudio.nord-visual-studio-code
        bbenoist.nix
        jnoortheen.nix-ide
        ms-vscode.cpptools
        redhat.java
        sumneko.lua
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "nord-palette";
          publisher = "Avetis";
          version = "0.1.0";
          sha256 = "sha256-GbILH4eeP2bNyaT/OmFQtgOrAFXu8g24qfpuVCM7Mys=";
        }
        {
          name = "Kanagawa";
          publisher = "qufiwefefwoyn";
          version = "1.5.1";
          sha256 = "sha256-AGGioXcK/fjPaFaWk2jqLxovUNR59gwpotcSpGNbj1c=";
        }
      ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 16;
      "editor.fontFamily" = config.theming.fonts.mono;
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "medium";
      "workbench.colorTheme" = "Kanagawa";
    };
  };
}
