return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'tokyonight-night',
      sections = {
        lualine_a = {
          'mode',
          'selection_count'
        },

        lualine_b = {
          'branch',
          'diff',
          'diagnostics'
        },

        lualine_c = {
          {'searchcount', icon = ''},
          'lsp_status',
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            color = { fg = '#ff9e64' }
          }
        },

        lualine_x = {
          'encoding',
          'fileformat',
          'filetype'
        },

        lualine_y = {
          {'filesize', icon = '', separator = ''},
          {'filename', path = 1},
        },

        lualine_z = {
          { 'datetime', style = '%H:%M', icon = '' }
        }
      }
    }
  }
}
