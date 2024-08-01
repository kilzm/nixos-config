{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autosuggestion = { enable = true; };
    enableCompletion = true;
    syntaxHighlighting = { enable = true; };

    history = {
      size = 99999;
      save = 99999;
    };

    initExtra = '''';

    shellAliases = {
      "code" = "codium";

      "nd" = "nix develop --command zsh";
      "nr" = "nix run";
      "ns" = "f() { nix shell nixpkgs#$1 --command zsh }; f";
      "nb" = "f() { nix build nixpkgs#$1 --command zsh }; f";

      "lg" = "lazygit";

      "e" = "yazi";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "fzf" "ripgrep" "fd" ];
    };

    plugins = [{
      name = "zsh-z";
      src = pkgs.zsh-z;
      file = "share/zsh-z/zsh-z.plugin.zsh";
    }];
  };

  home.sessionVariables = {
    TERM = "foot";
    SHELL = "zsh";
  };
}
