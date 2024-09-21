{ pkgs, config, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = (with pkgs.vscode-extensions;
      [
        vscodevim.vim
        jdinhlife.gruvbox
        arcticicestudio.nord-visual-studio-code
        bbenoist.nix
        jnoortheen.nix-ide
        ms-vscode.cpptools
        redhat.java
        sumneko.lua
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 16;
      "editor.fontFamily" = config.theming.fonts.mono;
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "medium";
    };
  };
}
