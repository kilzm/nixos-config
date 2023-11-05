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
      export TERM=kitty
      export EDITOR=nvim
    '';

    shellAliases = {
      # editors
      "code" = "codium";

      # nix
      "nd" = "nix develop --command zsh";
      "nr" = "nix run";

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
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];
  };
}