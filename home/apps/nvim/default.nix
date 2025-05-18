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
      clang-tools
      nodePackages.bash-language-server
      nil
      nixd
      lua-language-server
      texlab
      nodePackages.diagnostic-languageserver
      # ols
      marksman
      jdt-language-server
      glsl_analyzer
      nodePackages.typescript-language-server
      basedpyright
    ];

    plugins =
      (with allPlugins; [
        # theme
        nightfox-nvim

        # visual
        nvim-web-devicons
        vim-matchup
        alpha-nvim
        lualine-nvim
        dropbar-nvim
        nui-nvim
        noice-nvim

        # mini
        mini-ai
        mini-pairs
        mini-surround
        mini-comment
        mini-bracketed
        mini-files
        mini-operators
        mini-cursorword

        # file navigation
        plenary-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        harpoon2
        vim-tmux-navigator

        # code navigation
        flash-nvim
        outline-nvim
        aerial-nvim

        # language support
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-lspconfig
        blink-cmp
        luasnip
        friendly-snippets
        vimtex
        markdown-preview-nvim
        lazydev-nvim

        # debugging
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text

        # utility
        headlines-nvim
        gitsigns-nvim
        todo-comments-nvim
        vim-unicoder
        snacks-nvim
        which-key-nvim
      ])
      ++ [config-plugin];

    extraLuaConfig = ''
      require('config').init()
    '';
  };
}
