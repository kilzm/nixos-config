{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    shell = "${pkgs.zsh}/bin/zsh";

    shortcut = "Space";
    keyMode = "vi";
    escapeTime = 0;
    baseIndex = 1;
    mouse = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;

    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      resurrect
      continuum
    ];

    extraConfig = ''
      # binds
      unbind l
      bind l source-file ~/.config/tmux/tmux.conf

      set -s extended-keys on
      set-option -g xterm-keys on
      set -as terminal-features 'xterm*:extkeys'
      set-option -g allow-passthrough on

      bind | split-window -h
      bind - split-window -v
      bind t set -g status

      bind C-o display-popup -E "tms"
      bind C-j display-popup -E "tms switch"
      bind C-w display-popup -E "tms windows"
      bind C-i command-prompt -p "Rename active session to: " "run-shell 'tms rename %1'"
      bind C-l "run-shell 'tms refresh'"

      # resurrect
      set -g @resurrect-strategy-nvim 'session'

      # status
      set -g status-left-length 40
      set -g status-position top
      set -g status-justify centre

      set -g status-style bg=default
      set -g status-style fg=default

      set -g status-left "#[fg=#555555] #H ⟩ #S "
      set -g status-right "#[fg=#555555]%H:%M ⟨ %d-%m-%Y "

      set -g window-status-format " #[fg=#555555]#W: #I "
      set -g window-status-current-format " #[fg=white,bold]#W: #I "
    '';
  };

  home.packages = with pkgs; [
    tmux-sessionizer
  ];

  xdg.configFile."tms/config.toml".text = ''
    [[search_dirs]]
    path = "${config.home.homeDirectory}/projects"
    depth = 1

    [[search_dirs]]
    path = "${config.home.homeDirectory}/nixos-config"
    depth = 1
  '';
}
