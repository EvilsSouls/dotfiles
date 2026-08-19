return {
  'L3MON4D3/LuaSnip',
  -- enabled = false,
  -- version = 'v2.*',
  run = 'make install_jsregexp',

  dependencies = {
    'rafamadriz/friendly-snippets'
  },

  config = function()
    local ls = require('luasnip')

    ls.setup {
      -- Enable autotriggered snippets
      enable_autosnippets = true,

      -- Update dependent nodes more often
      update_events = 'TextChanged,TextChangedI',

      -- Use Tab to trigger visual selection
      store_selection_keys = '<Tab>'
    }

    vim.keymap.set({"i"}, "<C-y>", function() ls.expand() end, {silent = true})
    vim.keymap.set({"i", "s"}, "<Tab>", function() ls.jump( 1) end, {silent = true})
    vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})
    -- luasnip-native keymaps do not work due to blink.cmp. Instead
    -- the https://github.com/becknik/blink-cmp-luasnip-choice is used
    vim.keymap.set(
      {'i', 's'},
      '<C-f>',

      function()
        if ls.choice_active() then
          ls.change_choice(1)

          vim.notify("Inside choice node")
        else
          vim.notify("Not inside choice node")
        end
      end,

      {
        desc = "Cycle between choices if choice node is active",
        -- expr = true,
        silent = true
      }
    )

    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_lua').lazy_load({paths = "./lua/snippets/"})
  end
}
