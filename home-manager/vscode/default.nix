{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jdinhlife.gruvbox
      arcticicestudio.nord-visual-studio-code
      bbenoist.nix
      jnoortheen.nix-ide
      ms-vscode.cpptools
      redhat.java
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nord-palette";
        publisher = "Avetis";
        version = "0.1.0";
        sha256 = "sha256-GbILH4eeP2bNyaT/OmFQtgOrAFXu8g24qfpuVCM7Mys=";
      }
    ];
    userSettings = {
      "window.titleBarStyle" = "custom";
      "editor.fontSize" = 18;
      "editor.fontFamily" = "UbuntuMono Nerd Font";
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "medium";
      "workbench.colorTheme" = "Nord";
    };
  };
}