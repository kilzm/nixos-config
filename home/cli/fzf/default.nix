{...}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;

    defaultOptions = [
      "--color=16"
    ];
  };
}
