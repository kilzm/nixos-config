{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };

    history = {
      size = 99999;
      save = 99999;
    };

    initExtra = ''
      PF_INFO="ascii title os kernel uptime pkgs de shell" PF_COL3=5 pfetch
    '';

    shellAliases = {
      # editors
      "code" = "codium";

      # nix
      "nd" = "nix develop --command zsh";
      "nr" = "nix run";
      "ns" = "f() { nix shell nixpkgs#$1 --command zsh }; f";

      # git
      "gs" = "git status";
      "gc" = "git commit";

      # other
      "e" = "ranger";
      "t" = "(kitty $(pwd) & disown) > /dev/null 2>&1";
      "neofetch" = let img = ./neofetch/snowflake.png;
        in ''neofetch --kitty ${img} --image_size 500'';
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vi-mode"
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
    TERM = "kitty";
    SHELL = "zsh";
  };
}
