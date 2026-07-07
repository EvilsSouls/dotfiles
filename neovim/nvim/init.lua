-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Set specific settings when inside a gui such as neovide
require("config.gui")

-- Set builtin nvim options
require("config.options")

-- Set up plugins / packages
require("config.lazy")
-- Set up packages after lazy.nvim
require("config.packages")

-- Configure User Commands and Autocommands
require("config.commands")
-- Configure Keybindings
require("config.remap")

require("config.lsp")
