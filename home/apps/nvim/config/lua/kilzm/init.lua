local function init()
    require "kilzm.options"
    require "kilzm.remaps"
    require "kilzm.misc"
    require "kilzm.treesitter"
    require "kilzm.alpha"
    require "kilzm.tree"
    require "kilzm.telescope"
    require "kilzm.harpoon"
    require "kilzm.term"
    require "kilzm.cmp"
    require "kilzm.lsp"
    require "kilzm.whichkey"
    require "kilzm.flash"
    -- require "kilzm.trouble"
    require "kilzm.gitsigns"
    require "kilzm.aerial"
    require "kilzm.oil"
    require "kilzm.dap"
end

return {
    init = init,
}
