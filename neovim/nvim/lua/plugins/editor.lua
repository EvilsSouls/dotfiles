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
    opts = {},

    config = function(plugin, opts)
      require(plugin.name).setup(opts)
    end,

    init = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')

      local isInsideMarkup = require('utils.typst').isInsideMarkup
      npairs.add_rules({
        Rule('$', '$', 'typst'):with_pair(isInsideMarkup),
        Rule('*', '*', 'typst'):with_pair(isInsideMarkup),
        Rule('_', '_', 'typst'):with_pair(isInsideMarkup),
        Rule('<', '>', 'typst'):with_pair(isInsideMarkup),
        Rule('/*', '*/', 'typst'):with_pair(isInsideMarkup),
      })
    end
  },

  {
    'RRethy/nvim-treesitter-endwise',
    ft = { 'ruby', 'lua', 'vimscript', 'bash', 'elixir', 'fish', 'julia' }
  },

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
