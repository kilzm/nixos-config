local function init()
    require "kilzm.options"
    require "kilzm.remaps"
    require "kilzm.treesitter"
    require "kilzm.misc"
    require "kilzm.alpha"
    require "kilzm.tree"
    require "kilzm.telescope"
    require "kilzm.cokeline"
    require "kilzm.term"
    require "kilzm.cmp"
    require "kilzm.lsp"
    require "kilzm.whichkey"
    require "kilzm.flash"
    require "kilzm.trouble"
    require "kilzm.gitsigns"
    require "kilzm.aerial"
    require "kilzm.oil"
end

return {
    init = init,
}
