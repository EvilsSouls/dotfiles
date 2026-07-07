-- Only use Ruff as a formatter
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      lint = {
        enable = false
      }
    }
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"Python"},
  callback = function()
    vim.bo[0].formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"
  end
})

-- [[ Configure Diagnostics ]]
vim.diagnostic.config({virtual_text=true})
