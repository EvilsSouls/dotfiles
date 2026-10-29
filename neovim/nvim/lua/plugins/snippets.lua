return {

  'L3MON4D3/LuaSnip',
  -- enabled = false,
  -- version = 'v2.*',
  lazy = false,
  run = 'make install_jsregexp',

  dependencies = {
    'rafamadriz/friendly-snippets',
  },

  config = function()
    local ls = require('luasnip')

    ls.setup {
      -- Enable autotriggered snippets
      enable_autosnippets = true,

      -- Update dependent nodes more often
      update_events = 'TextChanged,TextChangedI',

      -- Use Tab to trigger visual selection
      cut_selection_keys = '<Tab>',
    }

    --[[ vim.keymap.set({ "i" }, "<C-y>", function() ls.expand() end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<Tab>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })
    -- luasnip-native keymaps do not work due to blink.cmp. Instead
    -- the https://github.com/becknik/blink-cmp-luasnip-choice is used
    vim.keymap.set(
      { 'i', 's' },
      '<C-j>',

      function()
        if ls.choice_active() then
          ls.change_choice(1)

          vim.notify("Inside choice node")
        else
          vim.notify("Not inside choice node")
        end
      end,

      {
        desc = 'Cycle between choices if choice node is active',
        -- expr = true,
        silent = true
      }
    ) ]]

    require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_lua').lazy_load { paths = './lua/snippets/' }
  end,

  keys = {
    {
      '<Leader>Lr',
      function()
        require('luasnip.loaders.from_lua').load { paths = './lua/snippets/' }
      end,
      desc = 'Reload Lua Snippets',
    },
    {
      '<Leader>Le',
      function()
        require('luasnip.loaders').edit_snippet_files()
      end,
      desc = 'Edit Snippets',
    },
  },

  init = function()
    local function trigger_visual_snippet(snippet)
      local cut_keys = vim.api.nvim_replace_termcodes(require('luasnip.util.select').cut_keys, true, false, true)
      vim.api.nvim_feedkeys(cut_keys, 'm', false)

      -- For some reason I can't explain, this function must be deferred again
      vim.defer_fn(function()
        require('luasnip').snip_expand(snippet)
        local esc_insert = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
        vim.api.nvim_feedkeys(esc_insert, 'm', false)
      end, 0)
    end

    local snippets = require('snippets.typst.utils.visual_snippets')

    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Set FileType specific keybindings for easily triggering visual snippets as a motion',
      pattern = 'typst',
      callback = function(_)
        vim.keymap.set('v', 'mc', function()
          trigger_visual_snippet(snippets.cancel_snippet)
        end)

        vim.keymap.set('v', 'md', function()
          trigger_visual_snippet(snippets.underbrace_snippet)
        end)

        vim.keymap.set('v', 'mo', function()
          trigger_visual_snippet(snippets.overbrace_snippet)
        end)

        vim.keymap.set('v', 'ml', function()
          trigger_visual_snippet(snippets.double_underline_snippet)
        end)

        vim.keymap.set('v', 'ms', function()
          trigger_visual_snippet(snippets.sqrt)
        end)

        vim.keymap.set('v', 'g/', function()
          trigger_visual_snippet(snippets.frac)
        end)
      end,
    })
  end,
}
