{ ... }: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;

      character = {
        success_symbol = "[](bold yellow)[](bold purple)[](bold green)";
        error_symbol = "[](bold yellow)[](bold purple)[](bold green)";
      };
    };
  };
}
