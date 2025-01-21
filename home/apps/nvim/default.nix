{ pkgs, inputs, ... }:
let
  allPlugins = pkgs.vimPlugins // (import ./plugins { inherit pkgs inputs; });
  config-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-config";
    doCheck = false;
    src = ./config;
  };
in
{
  home.packages = with pkgs; [
    neovim-remote
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimdiffAlias = true;

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
      ols
      marksman
      jdt-language-server
      glsl_analyzer
      nodePackages.typescript-language-server
      basedpyright
    ];

    plugins = (with allPlugins; [
      # themes
      mellifluous-nvim
      neomodern-nvim
      catppuccin-nvim
      kanagawa-nvim
      nordic-nvim
      gruvbox-material
      tokyonight-nvim

      # visual
      nvim-web-devicons
      vim-matchup
      alpha-nvim
      nvim-cokeline
      lualine-nvim
      nvim-nio

      # file navigation
      nvim-tree
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      harpoon2
      vim-tmux-navigator
      oil-nvim

      # code navigation
      aerial-nvim
      flash-nvim
      nvim-navic
      barbecue-nvim

      # language support
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      lsp_signature-nvim
      lspkind-nvim
      luasnip
      cmp_luasnip
      friendly-snippets
      neodev-nvim
      vimtex
      copilot-lua
      copilot-cmp
      nvim-jdtls
      markdown-preview-nvim

      # debugging
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text

      # utility
      goto-preview
      nvim-autopairs
      comment-nvim
      which-key-nvim
      trouble-nvim
      headlines-nvim
      gitsigns-nvim
      lazygit-nvim
      FTerm-nvim
      undotree
      todo-comments-nvim
      vim-unicoder
    ]) ++ [ config-plugin ];

    extraLuaConfig = ''
      require('kilzm').init()
    '';
  };
}
