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
vim.keymap.set("n", "<leader>h", "gT")
vim.keymap.set("n", "<leader>l", "gt")

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

vim.keymap.set("n", "<leader>tc", toggle_setting(vim.opt.cursorcolumn), {desc = "toggle cursor column"})
vim.keymap.set("n", "<leader>tn", toggle_setting(vim.opt.relativenumber), {desc = "toggle relative numbers"})
vim.keymap.set("n", "<leader>tw", toggle_setting(vim.opt.wrap), {desc = "toggle wrapping"})

-- Theme Toggles
vim.keymap.set("n", "<leader>ttf", function()
  local current_options = require('tokyonight.config').options
  current_options.transparent = not(current_options.transparent)

  print("Transparency:", current_options.transparent)

  require('tokyonight').setup(current_options)
  vim.cmd.colorscheme('tokyonight-night')
end, {desc="Toggle tokyonight's built-in transparency setting"})

vim.keymap.set("n", "<leader>ttd", function()
  ---@class tokyonight.Config
  local current_options = require('tokyonight.config').options

  if current_options.on_colors_backup == nil then
    print("Removing Darkened Background")
    current_options.on_colors_backup = current_options.on_colors
    current_options.on_colors = function(colors) end
  else
    print("Darkening Background")
    current_options.on_colors = current_options.on_colors_backup
    current_options.on_colors_backup = nil
  end

  require('tokyonight').setup(current_options)
  vim.cmd.colorscheme('tokyonight-night')
end, {desc="Toggle the color overrides darkening the backgrounds"})

-- -- Telescope Keybindings
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- fzf keybindings
local fzf = require'fzf-lua'
vim.keymap.set("", "<leader>f<space>", fzf.resume, {desc = "Resume last query"})
vim.keymap.set("", "<leader>fz", fzf.zoxide, {desc = "Change directory using Zoxide"})
vim.keymap.set("", "<leader>fd", fzf.files, {desc = "Find File"})
vim.keymap.set("", "<leader>fs", fzf.grep, {desc = "Search inside Files"})
vim.keymap.set("", "<leader>fe", fzf.global, {desc = "Select Files, Buffers and Symbols"})
vim.keymap.set("", "<leader>fj", fzf.lsp_document_symbols, {desc = "Search Symbols"})
vim.keymap.set("", "<leader>ff", fzf.lsp_finder, {desc = "Search through all LSP locations"})
vim.keymap.set("", "<leader>fb", fzf.buffers, {desc = "Select Buffer"})
vim.keymap.set("", "<leader>fh", fzf.history, {desc = "Traverse Opened File History"})
vim.keymap.set("", "<leader>ft", fzf.tabs, {desc = "Select Tab"})
vim.keymap.set("", "<leader>f/", fzf.search_history, {desc = "Traverse search history"})
vim.keymap.set("", "<leader>fu", fzf.undotree, {desc = "Traverse undo tree"})
vim.keymap.set("", "<leader>f:", fzf.command_history, {desc = "Traverse command history"})
vim.keymap.set("", "<leader>fg", fzf.help_tags, {desc = "Traverse help tags"})
vim.keymap.set("", "<leader>fm", fzf.marks, {desc = "Traverse marks"})
vim.keymap.set("", "<leader>fr", fzf.registers, {desc = "Pick register"})
vim.keymap.set("", "<leader>fk", fzf.keymaps, {desc = "Search keymaps"})
vim.keymap.set("", "<leader>fo", fzf.nvim_options, {desc = "Search options"})
vim.keymap.set("", "<leader>f<cr>", fzf.builtin, {desc = "Pick builtin Command"})

-- Bufferline Keybindings
vim.keymap.set('n', 'gu', vim.cmd.BufferLinePick)

-- Neotree Keybindings
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
