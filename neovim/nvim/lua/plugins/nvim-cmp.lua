return {
  {
    'L3MON4D3/LuaSnip',
    opts = {

    }
  },

  {
    'hrsh7th/nvim-cmp',

    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'https://codeberg.org/FelipeLema/cmp-async-path'},
      {'hrsh7th/cmp-cmdline'},
      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'},
      {'petertriho/cmp-git', ft = 'gitcommit' },
      {'chrisgrieser/cmp-nerdfont'},
      {'kdheepak/cmp-latex-symbols', ft = 'markdown'},
      {'nat-418/cmp-color-names.nvim', opts = {}, ft = {'markdown', 'html', 'css'}},
      {'mtoohey31/cmp-fish', ft = 'fish'}
    },

    config = function()
      -- require('cmp-color-names').setup()
      local cmp = require('cmp')

      cmp.setup({
        -- enabled = function()
          -- disable completion if the cursor is `Comment` syntax group.
          -- return not cmp.config.context.in_treesitter_capture('@comment')
        -- end,

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },

        -- Register nvim-cmp lsp capabilities
        vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        view = {
          docs = { auto_open = true }
        },

        performance = {
          max_view_entries = 10
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),

        sources = cmp.config.sources({
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim-lsp' },
          { name = 'luasnip' },
          { name = 'async_path' },
          { name = 'nerdfont' }
        }, {
          { name = 'buffer' },
        }),
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'async_path' }
        }, {
          { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      cmp.setup.filetype('fish', {
        sources = cmp.config.sources({
          { name = 'nvim-lsp' },
          { name = 'fish' },
          { name = 'luasnip' },
          { name = 'async_path' },
          { name = 'nerdfont' }
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.filetype('markdown', {
        sources = cmp.config.sources({
          { name = 'latex_symbols' },
          { name = 'color_names' },
          { name = 'luasnip' }
        })
      })

      cmp.setup.filetype({'html', 'css'}, {
        sources = cmp.config.sources({
          { name = 'nvim-lsp' },
          { name = 'async_path' },
          { name = 'color_names' },
          { name = 'luasnip' },
          { name = 'nerdfont' },
        }, {
          { name = 'buffer' }
        })
      })
    end
  }
}
