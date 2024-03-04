local function init()
    require "kilzm.options"
    require "kilzm.remaps"
    require "kilzm.treesitter"
    require "kilzm.misc"
    require "kilzm.tree"
    require "kilzm.telescope"
    require "kilzm.barbar"
    require "kilzm.term"
    require "kilzm.cmp"
    require "kilzm.lsp"
    require "kilzm.whichkey"
    require "kilzm.flash"
    require "kilzm.trouble"
    require "kilzm.gitsigns"
    require "kilzm.aerial"
end

return {
    init = init,
}
