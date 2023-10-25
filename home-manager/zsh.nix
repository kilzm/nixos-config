{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;

    initExtra = ''
      export TERM=kitty
      export EDITOR=nvim
    '';

    shellAliases = {
      # editors
      "vim" = "nvim";
      "code" = "codium";

      # nix
      "nd" = "nix develop --command zsh";
      "nr" = "nix run";

      # other
      "e" = "ranger";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "vi-mode"
      ];
    };
  };

}