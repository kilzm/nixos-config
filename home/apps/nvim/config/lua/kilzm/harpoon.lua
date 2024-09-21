local Remap    = require('kilzm.keymap')
local nnoremap = Remap.nnoremap

local harpoon = require('harpoon')
harpoon.setup()



nnoremap('<C-a>', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
nnoremap('<C-s>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon show buffers' })
nnoremap('<A-1>', function() harpoon:list():select(1) end, { desc = "Harpoon buffer 1"})
nnoremap('<A-2>', function() harpoon:list():select(2) end, { desc = "Harpoon buffer 2"})
nnoremap('<A-3>', function() harpoon:list():select(3) end, { desc = "Harpoon buffer 3"})
nnoremap('<A-4>', function() harpoon:list():select(4) end, { desc = "Harpoon buffer 4"})
nnoremap('<A-5>', function() harpoon:list():select(5) end, { desc = "Harpoon buffer 5"})

nnoremap('<C-CR>', function() harpoon:list():next({ ui_nav_wrap = true }) end, { desc = "Harpoon next buffer"})
nnoremap('<C-A-CR>', function() harpoon:list():prev({ ui_nav_wrap = true }) end, { desc = "Harpoon previous buffer"})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
nnoremap('<leader>fh', function() toggle_telescope(harpoon:list()) end, { desc = 'Find Harpoon buffers' })
