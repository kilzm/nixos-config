{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    autosuggestion = {
      enable = true;
    };
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };

    history = {
      size = 99999;
      save = 99999;
    };

    shellAliases = {
      code = "codium";

      nd = "nix develop --command zsh";
      nr = "nix run";
      ns = "f() { nix shell nixpkgs#$1 --command zsh }; f";
      nb = "f() { nix build $1 --command zsh }; f";

      gd = "git diff";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gu = "git pull";
      gl = ''git log --all --graph --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n"'';
      gb = "git branch";
      gs = "git status --short";
      gi = "git init";
      gcl = "git clone";

      lg = "lazygit";

      e = "yazi";
      c = "clear";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "fzf"
      ];
    };

    plugins = [
      {
        name = "zsh-z";
        src = pkgs.zsh-z;
        file = "share/zsh-z/zsh-z.plugin.zsh";
      }
    ];
  };

  home.sessionVariables = {
    TERMINAL = "ghostty";
    SHELL = "zsh";
  };
}
