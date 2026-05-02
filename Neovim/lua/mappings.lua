--- NOTE: This for mapping keymap bindings configuration
require "nvchad.mappings"

---@type function
local rw = require "custom.utils.rename_word"
local rs = require "custom.utils.random_word"
local tt = require "custom.utils.toggle_transparency"

---@type fun(mode: string|string[], lhs : string, rhs : string|function, opts?: table)
local map = vim.keymap.set

---@type {noremap : boolean, silent : boolean}
local options = { noremap = true, silent = true }

---@type table<string, Keymap>
local K = {}

K.win_left = {
    mode = "n",
    key = "<C-h>",
    func = "<C-w>h",
    desc = { desc = "Move to left window" },
    opts = { opts = options },
}

K.win_right = {
    mode = "n",
    key = "<C-l>",
    func = "<C-w>l",
    desc = { desc = "Move to right window" },
    opts = { opts = options },
}

K.win_down = {
    mode = "n",
    key = "<C-j>",
    func = "<C-w>j",
    desc = { desc = "Move to bottom window" },
    opts = { opts = options },
}

K.win_up = {
    mode = "n",
    key = "<C-k>",
    func = "<C-w>k",
    desc = { desc = "Move to top window" },
    opts = { opts = options },
}

K.indent_left = {
    mode = "v",
    key = "<",
    func = "<gv",
    desc = { desc = "Indent left and keep selection" },
    opts = { opts = options },
}

K.indent_right = {
    mode = "v",
    key = ">",
    func = ">gv",
    desc = { desc = "Indent right and keep selection" },
    opts = { opts = options },
}

K.toggle_transparency = {
    mode = "n",
    key = "<leader>tt",
    func = tt,
    desc = { desc = "Toggle nvchad trasparency" },
    opts = { opts = options },
}

K.move_line_down = {
    mode = "n",
    key = "<A-j>",
    func = ":m .+1<CR>==",
    desc = { desc = "Move line down" },
    opts = { opts = options },
}

K.move_line_up = {
    mode = "n",
    key = "<A-k>",
    func = ":m .-2<CR>==",
    desc = { desc = "Move line up" },
    opts = { opts = options },
}

K.move_selection_down = {
    mode = "v",
    key = "<A-j>",
    func = ":m '>+1<CR>gv=gv",
    desc = { desc = "Move selection down" },
    opts = { opts = options },
}

K.move_selection_up = {
    mode = "v",
    key = "<A-k>",
    func = ":m '<-2<CR>gv=gv",
    desc = { desc = "Move selection up" },
    opts = { opts = options },
}

K.split_vertical = {
    mode = "n",
    key = "<leader>sv",
    func = "<C-w>v",
    desc = { desc = "Split vertically" },
    opts = { opts = options },
}

K.split_horizontal = {
    mode = "n",
    key = "<leader>sh",
    func = "<C-w>s",
    desc = { desc = "Split horizontally" },
    opts = { opts = options },
}

K.split_equal = {
    mode = "n",
    key = "<leader>se",
    func = "<C-w>=",
    desc = { desc = "Equal split sizes" },
    opts = { opts = options },
}

K.split_close = {
    mode = "n",
    key = "<leader>sq",
    func = "<cmd>close<CR>",
    desc = { desc = "Close split" },
    opts = { opts = options },
}

K.rename = {
    mode = "n",
    key = "<leader>ra",
    func = rw,
    desc = { desc = "Language Server Protocol rename variable" },
    opts = { opts = options },
}

K.random = {
    mode = "n",
    key = "<leader>rs",
    func = rs,
    desc = { desc = "Create random strings" },
    opts = { opts = options },
}

K.cmd_mode = {
    mode = "n",
    key = ";",
    func = ":",
    desc = { desc = "CMD enter command mode" },
    opts = { opts = options },
}

K.exit_insert = {
    mode = "i",
    key = "jk",
    func = "<ESC>",
    desc = { desc = "Exit insert mode in insert mode" },
    opts = { opts = options },
}

K.code_action = {
    mode = "n",
    key = "<leader>ca",
    func = vim.lsp.buf.code_action,
    desc = { desc = "Language Server Protocol code action" },
    opts = { opts = options },
}

K.show_diagnostics = {
    mode = "n",
    key = "gl",
    func = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            border = "rounded",
            source = "always",
            prefix = "",
            scope = "cursor",
            header = { "Diagnostics ンタ" },
        })
    end,
    desc = { desc = "Show floating diagnostics information" },
    opts = { opts = options },
}

for _, v in pairs(K) do
    map(v.mode, v.key, v.func, v.desc)
end
