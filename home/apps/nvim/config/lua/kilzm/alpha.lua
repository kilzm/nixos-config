local art = {
    [[                                                ]],
    [[                                          _.oo. ]],
    [[                  _.u[[/;:,.         .odMMMMMM' ]],
    [[               .o888UU[[[/;:-.  .o@P^    MMM^   ]],
    [[              oN88888UU[[[/;::-.        dP^     ]],
    [[             dNMMNN888UU[[[/;:--.   .o@P^       ]],
    [[            ,MMMMMMN888UU[[/;::-. o@^           ]],
    [[            NNMMMNN888UU[[[/~.o@P^              ]],
    [[            888888888UU[[[/o@^-..               ]],
    [[           oI8888UU[[[/o@P^:--..                ]],
    [[        .@^  YUU[[[/o@^;::---..                 ]],
    [[      oMP     ^/o@P^;:::---..                   ]],
    [[   .dMMM    .o@^ ^;::---...                     ]],
    [[  dMMMMMMM@^`       `^^^^                       ]],
    [[ YMMMUP^                                        ]],
    [[  ^^                                            ]],
    [[                                                ]],
}

local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.type = "group"
dashboard.section.header.val = {
    {
        type = "text",
        val = art,
        opts = { hl = "Operator", position = "center" },
    }
}

dashboard.section.buttons.val = {
    dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
    dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
    dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
    dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
    dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
}

require('alpha').setup(dashboard.config)
