{...}: {
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    enableZshIntegration = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  home.sessionVariables = {
    EZA_ICON_SPACING = 2;
  };
}
