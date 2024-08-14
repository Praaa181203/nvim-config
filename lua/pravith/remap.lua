vim.g.mapleader = " "

-- Open explorer.
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move lines in visual mode.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join the bottom line and this line, i.e puts the bottom line to the end of the current line.
vim.keymap.set("n", "J", "mzJ`z")

-- To move up and down, but it puts the cursor in the middle.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- To move between code blocks like functions, etc.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste from clipboard.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Deletes without copying (WOW)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Obvious lol
vim.keymap.set("i", "<C-c>", "<Esc>")

-- TBF

vim.keymap.set("n", "Q", "<nop>")

-- Formats code using lsp lel.

vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and relplace in the whole file for the current word.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make current file an executable.
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/pravith/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Select all from any mode.
vim.keymap.set({ "n", "v", "i" }, "<C-g>", "<C-c>ggVG")

-- Neovim Tree toggle.
vim.keymap.set({ "n", "v" }, "<C-f>", "<cmd>NvimTreeFindFileToggle<CR>")

-- Open the error in a new model.
vim.keymap.set("n", "<leader>n", function()
    vim.diagnostic.open_float({ focus = true, focusable = true })
end)

-- Move left and right while in insert mode.
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")

-- Remove a charecter behind the cursor.
vim.keymap.set("i", "<C-h>", "<BS>")

-- Command mode remap start of the line
vim.keymap.set("c", "<C-a>", "<Home>")
-- Command mode remap right
vim.keymap.set("c", "<C-f>", "<Right>")
-- Command mode remap left
vim.keymap.set("c", "<C-b>", "<Left>")

-- Fold if not folded, unfold if folded
vim.keymap.set("n", "zz", function()
    local current_line_number, col = unpack(vim.api.nvim_win_get_cursor(0))
    local is_line_folded = vim.fn.foldclosed(current_line_number)
    if is_line_folded > 0 then
        vim.api.nvim_feedkeys("zd", "n", true)
    else
        local current_line = vim.api.nvim_get_current_line()
        local curly = "{}"
        local round = "()"
        local square = "[]"
        local triangle = "<>"
        local brackets = {}
        local is_start_last = {}
        brackets[curly] = 0
        brackets[round] = 0
        brackets[square] = 0
        brackets[triangle] = 0
        is_start_last[curly] = nil
        is_start_last[round] = nil
        is_start_last[square] = nil
        is_start_last[triangle] = nil
        for i = 1, #current_line do
            local c = current_line:sub(i, i)
            if c == "{" then
                brackets[curly] = brackets[curly] + 1
                is_start_last[curly] = true
            end
            if c == "}" then
                brackets[curly] = brackets[curly] - 1
                is_start_last[curly] = false
            end
            if c == "(" then
                brackets[round] = brackets[round] + 1
                is_start_last[round] = true
            end
            if c == ")" then
                brackets[round] = brackets[round] - 1
                is_start_last[round] = false
            end
            if c == "[" then
                brackets[square] = brackets[square] + 1
                is_start_last[square] = true
            end
            if c == "]" then
                brackets[square] = brackets[square] - 1
                is_start_last[square] = false
            end
            if c == "<" then
                brackets[triangle] = brackets[triangle] + 1
                is_start_last[triangle] = true
            end
            if c == ">" then
                brackets[triangle] = brackets[triangle] - 1
                is_start_last[triangle] = false
            end
        end
        if brackets[curly] ~= 0 then
            -- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
            if is_start_last[curly] then
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F{", "n", true) end, 0)
            else
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F}", "n", true) end, 0)
            end
            vim.defer_fn(function() vim.api.nvim_feedkeys("zf%", "n", true) end, 10)
        elseif brackets[round] ~= 0 then
            -- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
            if is_start_last[round] then
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F(", "n", true) end, 0)
            else
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F)", "n", true) end, 0)
            end
            vim.defer_fn(function() vim.api.nvim_feedkeys("zf%", "n", true) end, 10)
        elseif brackets[square] ~= 0 then
            -- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
            if is_start_last[square] then
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F[", "n", true) end, 0)
            else
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F]", "n", true) end, 0)
            end
            vim.defer_fn(function() vim.api.nvim_feedkeys("zf%", "n", true) end, 10)
        elseif brackets[triangle] ~= 0 then
            -- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
            if is_start_last[triangle] then
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F<", "n", true) end, 0)
            else
                vim.defer_fn(function() vim.api.nvim_feedkeys("$F>", "n", true) end, 0)
            end
            vim.defer_fn(function() vim.api.nvim_feedkeys("zf%", "n", true) end, 10)
        else
            local prompt = vim.fn.input("Do you want to colapse this whole paragraph? [y/N]")
            local yes_options = {
                ["y"] = true,
                ["Y"] = true,
            }
            if yes_options[prompt] then
                vim.api.nvim_feedkeys("vapkzf", "n", true)
            end
            vim.cmd("echo ''")
        end
    end
end)
