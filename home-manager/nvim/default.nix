{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  allPlugins = pkgs.vimPlugins // (import ./plugins { inherit pkgs inputs; });
in
{
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
      ccls
      nodePackages.pyright
      nodePackages.bash-language-server
      rnix-lsp
	    lua-language-server
      texlab
    ];

    plugins = with allPlugins; [
      # visual
      # nord-nvim
      nord-nvim-alt
      catppuccin-nvim
      startup-nvim

      # treesitter
      nvim-treesitter.withAllGrammars

      # tree
      nvim-web-devicons
      nvim-tree

      # telescope
      plenary-nvim
      telescope-nvim
      telescope-fzf-native-nvim

      # lsp, completion, snippets
      nvim-lspconfig
      cmp-nvim-lsp
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      friendly-snippets
      neodev-nvim
      vimtex

      # other
      undotree
      trouble-nvim
      comment-nvim
      barbar-nvim
      lualine-nvim
      headlines-nvim
      toggleterm-nvim
      nvim-autopairs
      error-lens-nvim
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
