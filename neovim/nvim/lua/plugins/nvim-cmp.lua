return {
  {
    'L3MON4D3/LuaSnip',
    -- tag = 'v2.*',
    run = 'make install_jsregexp',

    dependencies = {
      'rafamadriz/friendly-snippets'
    },

    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  },

  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'https://codeberg.org/FelipeLema/cmp-async-path'},
      {'hrsh7th/cmp-cmdline'},
      {'saadparwaiz1/cmp_luasnip'},
      {'petertriho/cmp-git', ft = 'gitcommit' },
      {'chrisgrieser/cmp-nerdfont'},
      {'kdheepak/cmp-latex-symbols', ft = 'markdown'},
      {'nat-418/cmp-color-names.nvim', opts = {}, ft = {'markdown', 'html', 'css'}},
      {'mtoohey31/cmp-fish', ft = 'fish'},
      {'onsails/lspkind.nvim'},
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'hrsh7th/cmp-nvim-lsp-document-symbol'},
      {'dmitmel/cmp-cmdline-history'},
      {'hrsh7th/cmp-calc'},
    },

    config = function()
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local luasnip = require('luasnip')

      -- Automatically inserts '(' after selecting function or method
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

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

        experimental = {
          ghost_text = true
        },

        view = {
          docs = { auto_open = true }
        },

        completion = {
          keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]], -- default pattern defined by nvim-cmp; /(-?\d+(\.\d+)?|\b\w+(-\w*)*)/g as a JS regex
          keyword_length = 2,
        },

        performance = {
          max_view_entries = 10
        },

        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol',
            menu = ({
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              latex_symbols = '[LaTeX]',
              async_path = '[Path]',
              nerdfont = '[NerdFont]',
              git = '[Git]',
              fish = '[Fish]',
              color_names = '[Colors]',
              nvim_lsp_signature_help = '[LSP Sig]',
              nvim_lsp_document_symbol = '[LSP Doc]',
              calc = '[Calc]'
            })
          }),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          -- ['<C-Space>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end

            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)

            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = 'luasnip', keyword_length = 1 },
          { name = 'lazydev', group_index = 0 },
          { name = 'nvim_lsp' },
          { name = 'async_path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'nerdfont', keyword_length = 3 },
          { name = 'buffer', keyword_length = 4 },
        }),
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
          { name = 'buffer', keyword_length = 4 },
        })
      })

      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline({
          ['<Tab>'] = {
            c = function (_)
              if cmp.visible() then
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                else
                  cmp.select_next_item()
                end
              end
            end
          }
        }),
        sources = {
          { name = 'buffer' },
          { name = 'cmdline_history' },
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
          ['<Tab>'] = {
            c = function (_)
              if cmp.visible() then
                if #cmp.get_entries() == 1 then
                  cmp.confirm({ select = true })
                else
                  cmp.select_next_item()
                end
              end
            end
          }
        }),
        sources = cmp.config.sources({
          { name = 'async_path' },
          { name = 'cmdline' },
          { name = 'cmdline_history' },
          { name = 'calc' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      cmp.setup.filetype('fish', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'fish' },
          { name = 'luasnip' },
          { name = 'async_path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'nerdfont', keyword_length = 3 },
          { name = 'buffer', keyword_length = 4 },
        })
      })

      cmp.setup.filetype('markdown', {
        sources = cmp.config.sources({
          { name = 'latex_symbols', option = {strategy = 2} },
          { name = 'color_names', keyword_length = 0, keyword_pattern = [[\(\\color{\)\@<=\w*]]},
          { name = 'luasnip' },
        }, {
          { name = 'calc' }
        })
      })

      cmp.setup.filetype({'html', 'css'}, {
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'async_path' },
          { name = 'color_names' },
          { name = 'luasnip' },
          { name = 'nerdfont', keyword_length = 3 },
          { name = 'buffer', keyword_length = 4 }
        })
      })
    end
  }
}
