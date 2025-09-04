return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'tokyonight-night',
      sections = {
        lualine_c = {
          {'filename', path = 1, symbols = {modified = ''}},
          {'diff', seperator = ''}
        },
        lualine_y = {
          {'filesize', icon = ''}
        },
        lualine_z = {
          { 'datetime', style = '%H:%M', icon = '' }
        }
      }
    }
  }
}
