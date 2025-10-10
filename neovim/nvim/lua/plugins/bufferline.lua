return {
  {
    'akinsho/bufferline.nvim',
    version = '4.9.1',
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
    end
  }
}
