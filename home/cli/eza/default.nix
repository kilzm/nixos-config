{ ... }: {
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  home.sessionVariables = { EZA_ICON_SPACING = 2; };
}
