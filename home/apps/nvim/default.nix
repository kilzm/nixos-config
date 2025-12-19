{
  pkgs,
  inputs,
  ...
}: let
  allPlugins = pkgs.vimPlugins // (import ./plugins {inherit pkgs inputs;});
  config-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-config";
    doCheck = false;
    src = ./src;
  };
in {
  home.packages = with pkgs; [
    neovim-remote
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # clipboard
      xclip
      wl-clipboard

      # lsp
      nodePackages.bash-language-server
      nil
      nixd
      lua-language-server
      texlab
      nodePackages.diagnostic-languageserver
      ols
      marksman
      jdt-language-server
      glsl_analyzer
      nodePackages.typescript-language-server
      basedpyright
    ] ++ (with inputs.stable.legacyPackages.${pkgs.system}; [
      clang-tools
    ]);

    plugins =
      (with allPlugins; [
        # theme
        nightfox-nvim
        gruvbox-material-nvim

        # visual
        nvim-web-devicons
        vim-matchup
        alpha-nvim
        dropbar-nvim
        nui-nvim
        noice-nvim

        # mini
        mini-ai
        mini-pairs
        mini-surround
        mini-operators
        mini-splitjoin
        mini-comment
        mini-bracketed
        mini-files
        mini-cursorword
        mini-hipatterns

        # code navigation
        vim-tmux-navigator
        flash-nvim

        # language support
        nvim-treesitter.withAllGrammars
        nvim-lspconfig
        blink-cmp
        luasnip
        friendly-snippets
        markdown-preview-nvim
        lazydev-nvim

        # debugging
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text

        # utility
        gitsigns-nvim
        todo-comments-nvim
        snacks-nvim
        which-key-nvim
      ])
      ++ [config-plugin];

    extraLuaConfig = ''
      require('config').init()
    '';
  };
}
