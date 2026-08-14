
local buffers = require("config.buffers")

-- Keybinds
vim.keymap.set('n','<leader>pv', vim.cmd.Ex)

-- Diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
  desc = "Show diagnostic",
})

vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, {
  desc = "Next diagnostic",
})

vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, {
  desc = "Previous diagnostic",
})

-- Files
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", {
  desc = "Save file",
})

-- Buffers
vim.keymap.set("n", "<leader>be", buffers.new, {
  desc = "New buffer",
})

vim.keymap.set("n", "<leader>bd", buffers.close, {
  desc = "Close buffer",
})

vim.keymap.set("n", "<leader>bwq", buffers.save_and_close, {
  desc = "Save and close buffer",
})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
