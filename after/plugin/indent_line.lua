vim.cmd [[highlight IndentBlanklineContextChar guifg=#eb6f92 gui=nocombine]]

local ibl = require("ibl")

ibl.setup {
    debounce = 0,
    whitespace = {
        highlight = { "Whitespace", "NonText" }
    },
    scope = {
        --exclude = { language = { "html" } },

        show_start = false,

        show_end = false,

        highlight = { "Function", "Label" },
    },
}
