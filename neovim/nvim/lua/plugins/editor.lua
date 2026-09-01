return {
  ---@todo perhaps consider adding preview to the actual buffer like other plugins do
  ---@todo highlights
  ---@todo set styling not of cursor but of entire line
  ---@todo jump to last branching
  ---@todo Set title
  ---@todo Change styling of path to more easily show connections
  ---@todo Folding
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",

    config = function ()
      require('atone').setup({
        ui = {
          compact = true
        },

        auto_attach = {
          enabled=false
        }
      })
    end,

    keys = {
      { "<leader>u", function() require('atone.core').toggle() end, desc="Toggle Undotree" }
    }
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      fast_wrap = {
        map = '<M-e>',
        end_key = 'l',
        after_key = '$'
      }
    },

    config = function(plugin, opts)
      require(plugin.name).setup(opts)
    end,

    init = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')
      local cond = require('nvim-autopairs.conds')
      local ts_conds = require('nvim-autopairs.ts-conds')

      local isInsideMarkup = require('utils.typst').isInsideMarkup
      local isInsideMath = require('utils.typst').isInsideMath
      npairs.add_rules({
        Rule('$', '$', 'typst'):with_pair(isInsideMarkup)
                               :with_move(isInsideMath)
                               :with_cr(isInsideMath),

        Rule('/*', '*/', 'typst'):with_pair(isInsideMarkup)
                                 :with_move(ts_conds.is_ts_node('comment'))
                                 :with_cr(ts_conds.is_ts_node('comment')),

        Rule('*', '*', 'typst'):with_pair(isInsideMarkup)
                               :with_move(ts_conds.is_ts_node('strong')),

        Rule('_', '_', 'typst'):with_pair(isInsideMarkup)
                               :with_move(ts_conds.is_ts_node('emph')),

        Rule('<', '>', 'typst'):with_pair(isInsideMarkup)
                               :with_move(ts_conds.is_ts_node('label'))
      })

      -- Copied from https://github.com/windwp/nvim-autopairs/wiki/Custom-rules#add-trailing-commas-to--inside-lua-tables
      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
      npairs.add_rules {
        -- Rule for a pair with left-side ' ' and right side ' '
        Rule(' ', ' ')
          -- Pair will only occur if the conditional function returns true
          :with_pair(function(opts)
            -- We are checking if we are inserting a space in (), [], or {}
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({
              brackets[1][1] .. brackets[1][2],
              brackets[2][1] .. brackets[2][2],
              brackets[3][1] .. brackets[3][2]
            }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          -- We only want to delete the pair of spaces when the cursor is as such: ( | )
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({
              brackets[1][1] .. '  ' .. brackets[1][2],
              brackets[2][1] .. '  ' .. brackets[2][2],
              brackets[3][1] .. '  ' .. brackets[3][2]
            }, context)
          end)
      }
      -- For each pair of brackets we will add another rule
      for _, bracket in pairs(brackets) do
        npairs.add_rules {
          -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
          Rule(bracket[1] .. ' ', ' ' .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts) return opts.char == bracket[2] end)
            :with_del(cond.none())
            :use_key(bracket[2])
            -- Removes the trailing whitespace that can occur without this
            :replace_map_cr(function(_) return '<C-c>2xi<CR><C-c>O' end)
        }
      end
    end
  },

  {
    'RRethy/nvim-treesitter-endwise',
    ft = { 'ruby', 'lua', 'vimscript', 'bash', 'elixir', 'fish', 'julia' }
  },

  ---@todo Use Tabout with Luasnip
  {
    'abecodes/tabout.nvim',
    enabled = false,
    lazy = false,
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>', -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' }
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
    },
    opt = true,  -- Set this to true if the plugin is optional
    event = 'InsertCharPre', -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  }
}
