{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = { add_newline = true; };
  };
}
