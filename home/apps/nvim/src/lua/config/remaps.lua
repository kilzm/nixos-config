local Remap = require('config.keymap')
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap

inoremap('jk', '<Esc>')

-- splitting
nnoremap("<leader>v", ":vsplit<CR>", { desc = 'Split vertically' })
nnoremap("<leader>h", ":split<CR>", { desc = 'Split horizontally' })
nnoremap("<A-h>", ":vertical resize -3<CR>")
nnoremap("<A-l>", ":vertical resize +3<CR>")
nnoremap("<A-k>", ":horizontal resize +3<CR>")
nnoremap("<A-j>", ":horizontal resize -3<CR>")

vnoremap(
    "n",
    [[:<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>]],
    silent
)


vnoremap("K", ":m '<-2<CR>gv=gv")
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("<", "<gv")
vnoremap(">", ">gv")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

xnoremap("<leader>d", "\"_d")
xnoremap("<leader>p", "\"_dP")
vnoremap("r", "\"_dp")

nnoremap("Q", "<nop>")
nnoremap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and Replace' })
