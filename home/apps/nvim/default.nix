{ pkgs, inputs, config, ... }:
let
  allPlugins = pkgs.vimPlugins // (import ./plugins { inherit pkgs inputs; });
  config-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-config";
    src = ./config;
  };
in
{
  theming.neovim = "kanagawa";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # clipboard
      xclip
      wl-clipboard

      # lsp
      clang-tools
      pyright
      nodePackages.bash-language-server
      nil
      nixd
      lua-language-server
      texlab
      typst-lsp
      nodePackages.diagnostic-languageserver
      ols
      marksman
      jdt-language-server
    ];

    plugins = (with allPlugins; [
      # visual
      catppuccin-nvim
      kanagawa-nvim
      nordic-nvim
      gruvbox-material
      tokyonight-nvim
      alpha-nvim
      vim-matchup

      # motion
      flash-nvim

      # treesitter
      nvim-treesitter.withAllGrammars

      # tree
      nvim-web-devicons
      nvim-tree

      # telescope
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim

      # lsp, completion, snippets
      nvim-lspconfig
      null-ls-nvim
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
      typst-vim
      copilot-lua
      copilot-cmp
      nvim-jdtls

      # other
      undotree
      trouble-nvim
      comment-nvim
      nvim-cokeline
      lualine-nvim
      headlines-nvim
      FTerm-nvim
      oil-nvim
      nvim-autopairs
      gitsigns-nvim
      lazygit-nvim
      markdown-preview-nvim
      which-key-nvim
      todo-comments-nvim
      aerial-nvim
      nabla-nvim
      vim-unicoder
    ]) ++ [ config-plugin ];

    extraLuaConfig = ''
      require('kilzm').init()
      vim.cmd.colorscheme("${config.theming.neovim}")
    '';
  };
}
