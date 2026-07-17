return {
  {
    'L3MON4D3/LuaSnip',
    -- version = 'v2.*',
    run = 'make install_jsregexp',

    dependencies = {
      'rafamadriz/friendly-snippets'
    },

    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  },

  ---@todo Perhaps consider cmp compat
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      'L3MON4D3/LuaSnip',
      'onsails/lspkind.nvim',
      'nvim-tree/nvim-web-devicons',
      -- 'MahanRahmati/blink-nerdfont.nvim', -- Does not fully work with v2 apparently
    },
    build = function()
      -- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
      -- you can use `gb` in `:Lazy` to rebuild the plugin as needed
      require('blink.cmp').build():pwait()
    end,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'default' },

      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      -- Does not work with v2
      -- providers = {
      --   nerdfont = {
      --     module = "blink-nerdfont",
      --     name = "Nerd Fonts",
      --     score_offset = 15,
      --   }
      -- },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"`
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "rust" },

      -- Configure luasnip as snippet engine to use with blink.cmp
      snippets = { preset = 'luasnip' },

      ---@todo Configure completions to more easily separate different kinds of sources, different columns, etc.
      ---@todo investigate whether lspkind is actually needed
      ---@todo change color of different kind symbols coming from different sources

      -- Configure Completion Menu
      completion = {
        documentation = {
          auto_show = true
        },

        -- Use lsp-kind and nvim-web-devicons as icons
        menu = {
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbol_map[ctx.kind] or ""
                  end

                  return icon .. ctx.icon_gap
                end,

                ---@todo Actually implement colors correctly, so that different sources / different kinds are highlighted correctly
                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = 'BlinkCmpKind'
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              },

              source_name = {
                text = function(ctx)
                  local source_abbreviations = {
                    Snippets = "S",
                    LSP = "L",
                    Path = "P",
                    Buffer = "B"
                  }

                  local name = source_abbreviations[ctx.source_name] or ctx.source_name

                  return "[" .. name .. "]"
                end
              }
            },

            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1},
              { "source_name" },
            }
          }
        }
      },
    },

    config = function(plugin, opts)
      require(plugin.name).setup(opts)

      vim.api.nvim_set_hl(0, "BlinkCmpSource", {link = 'Comment'})
      vim.api.nvim_set_hl(0, "BlinkCmpKind", {link = 'OkMsg'})
    end
  },

  --[[ {
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
      {'micangl/cmp-vimtex'}
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
          -- return not cmp.config.context.in_treesitter_capture('comment')
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
          -- Remove backslash at the end of pattern to once again get two square brackets next to each other
          keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]\], -- default pattern defined by nvim-cmp; /(-?\d+(\.\d+)?|\b\w+(-\w*)*)/g as a JS regex
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
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)

            elseif cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item()
              end

            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)

            elseif cmp.visible() then
              cmp.select_prev_item()

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
          { name = 'color_names', keyword_length = 0, keyword_pattern = [[\(\\color{\)\@<=\w*]\]}, -- remove backslash at the end to comment back in
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

      cmp.setup.filetype('tex', {
        sources = cmp.config.sources({
          { name = 'vimtex' },
          { name = 'luasnip', keyword_length = 1 },
          { name = 'nvim_lsp' },
          { name = 'async_path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'buffer', keyword_length = 4 },
        })
      })
    end
  } ]]
}
