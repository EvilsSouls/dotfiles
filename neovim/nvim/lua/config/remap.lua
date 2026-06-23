-- TODO: nohl, CTRL-O replaced with HL, Enter and Shift+Enter = Newline above and below
vim.keymap.set("", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "<Enter>", function() vim.fn.append(vim.fn.line('.'), '') vim.cmd('norm! j') end)
vim.keymap.set("n", "<S-Enter>", function() vim.fn.append(vim.fn.line('.')-1, '') vim.cmd('norm! k') end)
vim.keymap.set("n", "<leader>q", "q")
vim.keymap.set("n", "q", "<Nop>")

-- H and L are a lot more ergonomical than ^ and 0
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
-- Temporarily set 0 and $ to NOP, to break muscle memory
vim.keymap.set("n", "0", "<Nop>")
vim.keymap.set("n", "$", "<Nop>")

-- Buffer Navigation

-- Easily switch tabs
vim.keymap.set("n", "<leader>H", "gT")
vim.keymap.set("n", "<leader>L", "gt")

-- Easily switch alternate buffer
vim.keymap.set("n", "<BS>", "<C-^>")
vim.keymap.set("n", "<leader><BS><BS>", function ()
  local current_pos = vim.fn.getcurpos()
  vim.cmd(":e #")
  vim.fn.setpos('.', current_pos)
end)

-- Toggles

local function toggle_setting(setting)
  return function () setting = not(setting:get()) end
end

vim.keymap.set("n", "<leader>tc", toggle_setting(vim.opt.cursorcolumn))
vim.keymap.set("n", "<leader>tn", toggle_setting(vim.opt.relativenumber))
vim.keymap.set("n", "<leader>tw", toggle_setting(vim.opt.wrap))

-- Telescope Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Bufferline Keybindings
vim.keymap.set('n', 'gu', vim.cmd.BufferLinePick)
