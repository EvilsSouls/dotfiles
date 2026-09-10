-- TODO: nohl, CTRL-O replaced with HL, Enter and Shift+Enter = Newline above and below
-- TODO: Change Back and Forwards Keys to use Shift+h and Shift+L

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Give <Enter> and <S-Enter> custom keybindings, if the buffer is supposed to be edited',
  callback = function(args)
    if vim.bo[args.buf].buftype == '' then
      vim.keymap.set('n', '<Enter>', function()
        vim.fn.append(vim.fn.line('.'), '')
        vim.cmd('norm! j')
      end, { buf = args.buf })
      vim.keymap.set('n', '<S-Enter>', function()
        vim.fn.append(vim.fn.line('.') - 1, '')
        vim.cmd('norm! k')
      end, { buf = args.buf })
    end
  end,
})

-- H and L are a lot more ergonomical than ^ and 0
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')
-- Temporarily set 0 and $ to NOP, to break muscle memory
vim.keymap.set('', '0', '<Nop>')
vim.keymap.set('', '^', '<Nop>')
vim.keymap.set('', '$', '<Nop>')

vim.keymap.set('n', '0', vim.diagnostic.open_float, { desc = 'Open Diagnostic Float' })

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

--- Keybinds copied from https://www.reddit.com/r/neovim/s/sXO1WMqIb3

-- Center Cursor after motions
vim.keymap.set('', '<C-u>', '<C-u>zz')
vim.keymap.set('', '<C-d>', '<C-d>zz')

-- Don't leave visual mode when changing indent
vim.keymap.set('x', '>', '>gv', { noremap = true })
vim.keymap.set('x', '<', '<gv', { noremap = true })

-- Swap ; and :
vim.keymap.set({ 'n', 'x' }, ':', ';', { noremap = true })
vim.keymap.set({ 'n', 'x' }, ';', ':', { noremap = true })

-- Buffer Navigation

-- Map <C-j>, <C-k>, <C-h>, <C-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<C-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<C-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<C-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<C-l>', '<C-w>l')

-- File Keybinds
vim.keymap.set('', '<leader>fs', function()
  vim.cmd('w')
end, { desc = 'Save File' })
vim.keymap.set('', '<leader>fq', function()
  vim.cmd('q')
end, { desc = 'Close File' })

-- Editor Keybinds
vim.keymap.set('', '<leader>eq', function()
  vim.cmd('qa')
end, { desc = 'Exit Neovim' })

-- Session Keybinds
-- Loosely copied from https://www.reddit.com/r/neovim/comments/xazxxe/help_savingcreating_file/inwtkis?utm_medium=android_app&utm_source=share&context=3
vim.keymap.set('', '<leader>ss', function()
  vim.ui.input({ prompt = 'Enter session name' }, function(session_file_name)
    local ok, err = pcall(vim.cmd.mksession, session_file_name .. '.vim')

    if not ok then
      -- clear `vim.ui.input` from cmdline to make space for an error
      vim.cmd.redraw()
      vim.notify(err, vim.log.levels.ERROR, {
        title = 'error while saving session',
      })
    end
  end)
  vim.cmd('mksession')
end)

-- Easily switch tabs
vim.keymap.set('n', '<leader>h', 'gT')
vim.keymap.set('n', '<leader>l', 'gt')

-- Easily switch alternate buffer
vim.keymap.set('n', '<BS>', '<C-^>')
vim.keymap.set('n', '<leader><BS><BS>', function()
  local current_pos = vim.fn.getcurpos()
  vim.cmd(':e #')
  vim.fn.setpos('.', current_pos)
end)

-- Toggles

local function toggle_setting(setting)
  local toggle_function = function()
    local new_val = not (vim.opt[setting]:get())
    vim.opt[setting] = new_val
    vim.notify('Set option ' .. setting .. ' to ' .. tostring(new_val))
  end
  return toggle_function
end

---@todo peraps actually implement this
-- -- Idea stolen from https://www.reddit.com/r/neovim/comments/uq85hr/comment/i96whcy
-- local function toggle_setting_states(setting, on, off)
--
-- end

vim.keymap.set('n', '<leader>th', toggle_setting('hlsearch'), { desc = 'toggle search highlighting' })
vim.keymap.set('n', '<leader>tc', toggle_setting('cursorcolumn'), { desc = 'toggle cursor column' })
vim.keymap.set('n', '<leader>tn', toggle_setting('relativenumber'), { desc = 'toggle relative numbers' })
vim.keymap.set('n', '<leader>tw', toggle_setting('wrap'), { desc = 'toggle wrapping' })
