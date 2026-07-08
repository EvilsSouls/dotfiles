-- TODO: nohl, CTRL-O replaced with HL, Enter and Shift+Enter = Newline above and below
-- TODO: Change Back and Forwards Keys to use Shift+h and Shift+L

vim.keymap.set("", "<leader>nh", ":nohl<CR>")
vim.keymap.set("n", "<leader>q", "q")
vim.keymap.set("n", "q", "<Nop>")

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = "Give <Enter> and <S-Enter> custom keybindings, if the buffer is supposed to be edited",
  callback = function (args)
    if vim.bo[args.buf].buftype == "" then
      vim.keymap.set("n", "<Enter>", function() vim.fn.append(vim.fn.line('.'), '') vim.cmd('norm! j') end, {buf=args.buf})
      vim.keymap.set("n", "<S-Enter>", function() vim.fn.append(vim.fn.line('.')-1, '') vim.cmd('norm! k') end, {buf=args.buf})
    end
  end
})

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

vim.keymap.set("n", "<leader>Tc", toggle_setting("cursorcolumn"), {desc = "toggle cursor column"})
vim.keymap.set("n", "<leader>Tn", toggle_setting("relativenumber"), {desc = "toggle relative numbers"})
vim.keymap.set("n", "<leader>Tw", toggle_setting("wrap"), {desc = "toggle wrapping"})

-- Bufferline Keybindings
vim.keymap.set('n', 'gu', vim.cmd.BufferLinePick)

-- Neotree Keybindings
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree<CR>")
