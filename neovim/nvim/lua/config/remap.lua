-- TODO: nohl, CTRL-O replaced with HL, Enter and Shift+Enter = Newline above and below
vim.keymap.set("", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "<Enter>", function() vim.fn.append(vim.fn.line('.'), '') vim.cmd('norm! j') end)
vim.keymap.set("n", "<S-Enter>", function() vim.fn.append(vim.fn.line('.')-1, '') vim.cmd('norm! k') end)
vim.keymap.set("n", "<leader>q", "q")
vim.keymap.set("n", "q", "<Nop>")

-- Telescope Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
