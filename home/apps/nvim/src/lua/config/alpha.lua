local hydra = {
    "                                   ",
    "                                   ",
    "                                   ",
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    "                                   ",
}

local hk = {
"          ░▒███     ███░       ",
"         ░▒▒█▓▒      ▒▒▓█░░     ",
"       ░░▒██▓▓▓      ▓▓▓▓██░░   ",
"       ░▒█▓▒░           ░▓█▒░   ",
"       ░▒█▓▒░           ░▓█▒░   ",
"       ░▒█▓▒▒          ░▒▓█▒░   ",
"       ░▒██▓▓▒▒▒▒▒▒▒▒▒▒▓▓██░    ",
"     ░░▒▒███████████████████▓░  ",
"    ░░▒▓█████████████████████▓░ ",
"   ░▒▒▓██████████████████████▓▒░",
" ░ ░▒▓███████████████████████▓▒░",
" ░ ░▒▓███████████    ███████  ▒▒",
" ░ ░▒▓█████████        ████    ▒",
"   ░░▒▓████████        ████    ▒",
"     ░░▒▒▓███████    ███████  ▒ ",
"       ░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒  ",
"          ░░░░░░░░░░░░░░░░░░    ",
}

local dashboard = require('alpha.themes.dashboard')

dashboard.section.header.type = "group"
dashboard.section.header.val = {
    {
        type = "text",
        val = hk,
        opts = { position = "center" },
    }
}

local snacks = require('snacks')

dashboard.section.buttons.val = {
    dashboard.button("f", " " .. " Find file", function() snacks.picker.files() end),
    dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
    dashboard.button("r", " " .. " Recent files", function() snacks.picker.recent() end),
    dashboard.button("g", " " .. " Find text", function() snacks.picker.grep() end),
    dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
}

require('alpha').setup(dashboard.config)
