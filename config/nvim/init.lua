-- NeoVim config
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Imports
require("config.lazy")
require("config.undo")
require("config.options")
require("config.keymap")

