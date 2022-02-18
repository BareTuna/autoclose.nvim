local map = vim.api.nvim_set_keymap
local modules = require("autoclose.modules")

local M = {}

M.auto_close = function()
    map("i", "{", "{}<ESC>i", {noremap = true})
    map("i", "[", "[]<ESC>i", {noremap = true})
    map("i", "(", "()<ESC>i", {noremap = true})
    map("i", "'", "''<ESC>i", {noremap = true})
    map("i", "\"", "\"\"<ESC>i", {noremap = true})
end

M.auto_delete = function()
    local line = vim.fn.getpos(".")[2]
    local col = vim.fn.getpos(".")[3]

    local cursor_line = vim.api.nvim_buf_get_lines(0, line - 1, line, 0)[1]
    local cursor_left = string.sub(cursor_line, col - 1, col - 1)
    local cursor_position = string.sub(cursor_line, col, col)

    if modules.delete(cursor_left) and cursor_position == modules.pair(cursor_left) then
	map("i", "<BS>", "<ESC>2s", {noremap = true})
    else
	map("i", "<BS>", "<BS>", {noremap = true})
    end
end

return M
