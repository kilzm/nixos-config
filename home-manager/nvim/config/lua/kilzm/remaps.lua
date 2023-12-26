local Remap = require('kilzm.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

inoremap('jk', '<Esc>')

-- splitting
nnoremap("<leader>v", ":vsplit<CR>")
nnoremap("<leader>h", ":split<CR>")
nnoremap("<A-h>", "<C-w>h")
nnoremap("<A-j>", "<C-w>j")
nnoremap("<A-k>", "<C-w>k")
nnoremap("<A-l>", "<C-w>l")
nnoremap("<A-Left>", ":vertical resize -3<CR>")
nnoremap("<A-Right>", ":vertical resize +3<CR>")
nnoremap("<A-Up>", ":horizontal resize +3<CR>")
nnoremap("<A-Down>", ":horizontal resize -3<CR>")

vnoremap(
    "n",
    [[:<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>]],
    silent
)

vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("J", ":m '>+1<CR>gv=gv")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

xnoremap("<leader>d", "\"_d")
xnoremap("<leader>p", "\"_dp")
xnoremap("<leader>P", "\"_dP")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")

nnoremap("Q", "<nop>")
nnoremap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

nnoremap("<leader>u", vim.cmd.UndoTreeToggle)

local hm_switch = function ()
    vim.cmd("!home-manager switch --flake $HOME/nixos-config\\#kilianm")
end
nnoremap("<leader>cr", hm_switch)

local build_open_pdf = function ()
    vim.cmd("!nix build")
    vim.cmd("!evince result/out.pdf")
end
nnoremap("<leader>cb", build_open_pdf)

