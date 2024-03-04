local globals = {
    mapleader = ' ',
    maplocalleader = ' ',
    loaded_netrw = 1,
    loaded_netrwPlugin = 1,
}


local options = {
    autoindent = true,
    smartindent = true,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    scrolloff = 8;
    sidescrolloff = 8;

    number = true,
    relativenumber = true,
    numberwidth = 4,
    incsearch = true,
    hlsearch = false,
    ignorecase = true,
    smartcase = true,

    splitright = true,
    splitbelow = true,

    wrap = false,
    fileencoding = 'utf-8',
    clipboard = 'unnamedplus',
    signcolumn = 'yes',
    termguicolors = true,

    backup = false,
    writebackup = false,
    swapfile = false,
    undofile = true,
    undodir = os.getenv('HOME') .. "/.vim/undodir",

    mouse = 'a',
    updatetime = 300,

    shell = 'zsh',
    title = true,
    titlestring = "Neovim - %t",
    linespace = 1,
}

for global, value in pairs(globals) do
    vim.g[global] = value
end

for option, value in pairs(options) do
    vim.o[option] = value
end
