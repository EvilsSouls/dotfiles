return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'tokyonight-night',
      globalstatus = true,
      extensions = {'nvim-tree', 'fzf', 'trouble'},
      sections = {
        lualine_a = {
          {'mode'},
          {'selectioncount', icon = '󰸱'},
          {'searchcount', icon = ''},
        },

        lualine_b = {
          {'location', separator = '', icon = '󰆋', fmt = function(str) return vim.trim(str) end },
          {'progress', icon = '󰍎'},
          'branch',
          'diff',
        },

        lualine_c = {
          'lsp_status',
          'diagnostics',
        },

        lualine_x = {
          {'encoding', fmt = function(str) return str:gsub("^utf%-8$", "") end}, -- Idea taken from https://www.reddit.com/r/neovim/comments/u2uc4p/comment/i4muvp6/
          {'fileformat', fmt = function(str) return str:gsub("^$", "") end}, -- Idea taken from https://www.reddit.com/r/neovim/comments/u2uc4p/comment/i4muvp6/
          'filetype'
        },

        lualine_y = {
          {'filesize', icon = '', separator = ''},
          {'filename', path = 1, icon = '󰈙'},
        },

        lualine_z = {
          {'datetime', style = '%H:%M', icon = ''},
          {require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" }}
        }
      }
    }
  }
}
