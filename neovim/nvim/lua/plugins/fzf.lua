return {
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {},
    config = function(plugin, opts)
      require(plugin.name).setup(opts)

      require(plugin.name).register_ui_select()
    end,
    ---@diagnostic enable: missing-fields
    keys = {
      -- fzf keybindings
      {
        '<leader>F<space>',
        function()
          require('fzf-lua').resume()
        end,
        desc = 'Resume last query',
      },
      {
        '<leader>c',
        function()
          require('fzf-lua').zoxide()
        end,
        desc = 'Change directory using Zoxide',
      },
      {
        '<leader>fd',
        function()
          require('fzf-lua').files()
        end,
        desc = 'Find File',
      },
      {
        '<leader>ps',
        function()
          require('fzf-lua').grep()
        end,
        desc = 'Search inside Files',
      },
      {
        '<leader>pe',
        function()
          require('fzf-lua').global()
        end,
        desc = 'Select Files, Buffers and Symbols',
      },
      {
        '<leader>pj',
        function()
          require('fzf-lua').lsp_document_symbols()
        end,
        desc = 'Search Symbols',
      },
      {
        '<leader>pf',
        function()
          require('fzf-lua').lsp_finder()
        end,
        desc = 'Search through all LSP locations',
      },
      {
        '<leader>sb',
        function()
          require('fzf-lua').buffers()
        end,
        desc = 'select buffer',
      },
      {
        '<leader>fh',
        function()
          require('fzf-lua').history()
        end,
        desc = 'file history',
      },
      {
        '<leader>st',
        function()
          require('fzf-lua').tabs()
        end,
        desc = 'select tab',
      },
      {
        '<leader>s/',
        function()
          require('fzf-lua').search_history()
        end,
        desc = 'search history',
      },
      {
        '<leader>s:',
        function()
          require('fzf-lua').command_history()
        end,
        desc = 'command history',
      },
      {
        '<leader>eh',
        function()
          require('fzf-lua').help_tags()
        end,
        desc = 'help tags',
      },
      {
        '<leader>sm',
        function()
          require('fzf-lua').marks()
        end,
        desc = 'marks',
      },
      {
        '<leader>sr',
        function()
          require('fzf-lua').registers()
        end,
        desc = 'pick register',
      },
      {
        '<leader>ek',
        function()
          require('fzf-lua').keymaps()
        end,
        desc = 'search keymaps',
      },
      {
        '<leader>eo',
        function()
          require('fzf-lua').nvim_options()
        end,
        desc = 'editor options',
      },
      {
        '<leader>F<cr>',
        function()
          require('fzf-lua').builtin()
        end,
        desc = 'Pick builtin Command',
      },
    },
  },
}
