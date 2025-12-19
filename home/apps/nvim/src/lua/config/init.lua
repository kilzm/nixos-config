local function init()
    require "config.options"
    require "config.remaps"
    require "config.mini"
    require "config.snacks"
    require "config.flash"
    require "config.ts"
    require "config.lsp"
    require "config.snippets"
    require "config.completion"
    require "config.dap"
    require "config.git"
    require "config.color"
    require "config.alpha"
    require "config.noice"
    require "config.whichkey"
end

return {
    init = init,
}
