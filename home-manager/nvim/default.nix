{
  pkgs,
  cmn,
  inputs,
  ...
}:

let
  allPlugins = pkgs.vimPlugins // (import ./plugins { inherit pkgs inputs; });
  config-plugin = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-config";
    src = ./config;
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = pkgs.neovim-nightly;

    extraPackages = with pkgs; [
      # clipboard
      xclip
      wl-clipboard

      # lsp
      clang-tools
      nodePackages.pyright
      nodePackages.bash-language-server
      nil
      nixd
	    lua-language-server
      texlab
      typst-lsp
      nodePackages.diagnostic-languageserver
      ols
      marksman
    ];

    plugins = with allPlugins; [
      # visual
      nord-nvim-alt
      catppuccin-nvim
      kanagawa-nvim
      alpha-nvim
      gruvbox-material
      tokyonight-nvim
      
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
      cmp-nvim-lsp-signature-help
      lspkind-nvim
      luasnip
      cmp_luasnip
      friendly-snippets
      neodev-nvim
      vimtex
      typst-vim
      odin-vim
      copilot-lua
      copilot-cmp

      # other
      undotree
      trouble-nvim
      comment-nvim
      nvim-cokeline
      lualine-nvim
      headlines-nvim
      FTerm-nvim
      nvim-autopairs
      gitsigns-nvim
      lazygit-nvim
      markdown-preview-nvim
      which-key-nvim
      todo-comments-nvim
      aerial-nvim

      # config
      config-plugin
    ];

    extraLuaConfig = ''
			require('kilzm').init()
      vim.cmd.colorscheme("${cmn.scheme.name}")
    '';
  };
}
