return {
  -- -- For Nvim 0.11
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   lazy = false,
  --   build = ':TSUpdate',
  --   ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "fish", "html", "javascript", "json", "jsonc", "toml", "javascript", "latex", "yaml" },
  --   dependencies = {
  --       {'nvim-treesitter/nvim-treesitter-context', opts = {}}
  --   },
  --   highlight = {
  --     enable = true
  --   },
  --   incremental_selection = {
  --     enable = true,
  --     keymaps = {
  --       init_selection = "<Leader>tv",
  --       node_incremental = "<Leader>ti",
  --       scope_incremental = "<Leader>ts",
  --       node_decremental = "<Leader>td"
  --     }
  --   },
  --   indentation = {
  --     enable = true
  --   }
  -- }

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      {'nvim-treesitter/nvim-treesitter-context', opts = {}}
    },
    init = function ()
      require('nvim-treesitter').install { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'bash', 'fish', 'html', 'javascript', 'json', 'toml', 'javascript', 'latex', 'yaml'}

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '<filetype>' },
        callback = function()
          -- Treesitter Highlighting
          vim.treesitter.start()

          -- Treesitter Folding
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'

          -- Treesitter indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end
  },

  -- TODO: Actually configure text objects, to more efficiently navigate a buffer
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {},
    init = function ()
      vim.g.no_plugin_maps = true
    end
  }
}
