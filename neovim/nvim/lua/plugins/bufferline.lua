return {
  {
    'akinsho/bufferline.nvim',
    version = '4.9.1',
    ---@todo Investigate whether lazy loading may be enabled
    lazy = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = 'tabs',
          diagnostics = 'nvim_lsp',
          separator_style = 'slope',
          numbers = function (opts)
            return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
          end
        }
      }
    end,

    keys = {
      {'gu', vim.cmd.BufferLinePick, desc = "Change Tabs"}
    }
  }
}
