-- NeoVim config
-- LazyVim plugin manager
require("config.lazy")

-- Appearance
vim.opt.number = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Leader key
vim.g.mapleader = " "

-- Keybinds
vim.keymap.set('n','<leader>pv', vim.cmd.Ex)
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Transparent background
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")

-- Imports
require("config.undo")

