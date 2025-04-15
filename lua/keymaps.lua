-- lua/keymaps.lua
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Insert mode mappings
-- Insert mode: Option + Arrow to move by word
keymap("i", "<C-d>", "<Del>", opts)       -- Delete next char (already in init.lua)
