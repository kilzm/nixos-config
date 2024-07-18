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
        {
          name = "monochrome";
          publisher = "anotherglitchinthematrix";
          version = "2.4.3";
          sha256 = "sha256-xk4YTT6a1RW/JnWl+r7O0c3ZN/lZM7uiEnCc9h7smZc=";
        }
      ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 16;
      "editor.fontFamily" = config.theming.fonts.mono;
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "medium";
      "workbench.colorTheme" = "Monochrome Dark";
    };
  };
}
