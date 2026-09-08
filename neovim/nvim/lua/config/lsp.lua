---@todo Use Conform.nvim for formatter configuration
---@todo Consider instead creating a folder and configuring each of the lsps in files that are named after the LSP inside that folder

vim.lsp.config('tinymist', {
  settings = {
    formatterMode = 'typstyle',
    formatterProseWrap = true, -- wrap lines in content mode
    formatterPrintWidth = 80, -- limit line length to 80 if possible
    formatterIndentSize = 2, -- indentation width
  },
})

-- [[ Configure Diagnostics ]]
vim.diagnostic.config {
  -- virtual_text=true
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '󰌵',
      [vim.diagnostic.severity.INFO] = '󰋼',
    },
  },
}
