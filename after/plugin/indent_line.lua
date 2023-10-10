vim.cmd [[highlight IndentBlanklineContextChar guifg=#eb6f92 gui=nocombine]]

require("indent_blankline").setup {
    space_char_blankline = " ",
    indent_blankline_context_highlight_list = {
        "IndentBlanklineCurrentContextSpaceChar",
    },
    show_current_context = true,
}
