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
end

return {
    init = init,
}
