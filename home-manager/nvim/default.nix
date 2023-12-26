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

    extraPackages = with pkgs; [
      # clipboard
      xclip
      wl-clipboard

      # lsp
      clang-tools
      nodePackages.pyright
      nodePackages.bash-language-server
      rnix-lsp
      nil
	    lua-language-server
      texlab
      typst-lsp
      nodePackages.diagnostic-languageserver
      ols
    ];

    plugins = with allPlugins; [
      # visual
      nord-nvim-alt
      catppuccin-nvim
      kanagawa-nvim
      startup-nvim
      nvim-base16
      
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

      # lsp, completion, snippets
      nvim-lspconfig
      null-ls-nvim
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
      typst-vim

      # other
      undotree
      trouble-nvim
      comment-nvim
      nvim-cokeline
      lualine-nvim
      headlines-nvim
      toggleterm-nvim
      nvim-autopairs
      error-lens-nvim

      # config
      config-plugin
    ];

    extraLuaConfig = ''
			require('kilzm').init()
      vim.cmd.colorscheme("${cmn.scheme.name}")
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'kanagawa',
          component_separators = { left = '', right = '' },
          section_separators = {  left = '', right = '' },
        },
      })
    '';
  };
}
