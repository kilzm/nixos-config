{ ... }: {
  programs.eza = {
    enable = true;
    icons = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = { EZA_ICON_SPACING = 2; };
}
