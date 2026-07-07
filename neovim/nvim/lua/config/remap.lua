-- TODO: nohl, CTRL-O replaced with HL, Enter and Shift+Enter = Newline above and below
-- TODO: Change Back and Forwards Keys to use Shift+h and Shift+L

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

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Buffer Navigation

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

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
  local toggle_function = (function()
    local new_val = not(vim.opt[setting]:get())
    vim.opt[setting] = new_val
    vim.notify("Set option " .. setting .. " to " .. tostring(new_val))
  end)
  return toggle_function
end

---@todo peraps actually implement this
-- -- Idea stolen from https://www.reddit.com/r/neovim/comments/uq85hr/comment/i96whcy
-- local function toggle_setting_states(setting, on, off)
--   
-- end

vim.keymap.set("n", "<leader>tc", toggle_setting("cursorcolumn"), {desc = "toggle cursor column"})
vim.keymap.set("n", "<leader>tn", toggle_setting("relativenumber"), {desc = "toggle relative numbers"})
vim.keymap.set("n", "<leader>tw", toggle_setting("wrap"), {desc = "toggle wrapping"})

-- Theme Toggles
vim.keymap.set("n", "<leader>ttf", function()
  local current_options = require('tokyonight.config').options
  local new_val = not(current_options.transparent)
  current_options.transparent = new_val

  vim.notify("Set built-in transparency to " .. tostring(new_val))
  print("Transparency:", current_options.transparent)

  -- Refresh colorscheme
  require('tokyonight').setup(current_options)
  vim.cmd.colorscheme('tokyonight-night')
end, {desc="Toggle tokyonight's built-in transparency setting"})

vim.keymap.set("n", "<leader>ttd", function()
  ---@class tokyonight.Config
  local current_options = require('tokyonight.config').options

  if current_options.on_colors_backup == nil then
    vim.notify("Set background back to normal")
    current_options.on_colors_backup = current_options.on_colors
    current_options.on_colors = function(colors) end
  else
    vim.notify("Darkened the background")
    current_options.on_colors = current_options.on_colors_backup
    current_options.on_colors_backup = nil
  end

  require('tokyonight').setup(current_options)
  vim.cmd.colorscheme('tokyonight-night')
end, {desc="Toggle the color overrides darkening the backgrounds"})

---@todo Make toggle functions to toggle terminal transparency.
--- Perhaps also make changing the darkening of colors also chane the values that the terminal makes transparent
--- so that there are two independent toggles: darkening of background and transparency of terminal

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
