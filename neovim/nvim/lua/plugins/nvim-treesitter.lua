return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      {'nvim-treesitter/nvim-treesitter-context', opts = {}}
    },
    config = function ()
      require('nvim-treesitter').setup({})

      require('nvim-treesitter').install {
        'c',
        'lua',
        'rust',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'markdown_inline',
        'bash',
        'fish',
        'html',
        'json',
        'toml',
        'javascript',
        'latex',
        'yaml',
        'python',
        'typescript',
        'gitcommit'
      }

      -- Folds should default to open
      vim.o.foldlevelstart = 99

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'python', 'javascript', 'rust', 'markdown', 'typescript' },
        callback = function()
          -- Treesitter Folding
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          -- Treesitter Highlighting
          vim.treesitter.start()

          -- Treesitter indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end
  },

  ---@todo: Actually configure text objects, to more efficiently navigate a buffer
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {},
    init = function ()
      vim.g.no_plugin_maps = true
    end
  }
}
