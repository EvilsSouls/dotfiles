return {
  {
    "epwalsh/obsidian.nvim",
    version = "3.9.0",
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
      --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      --   -- refer to `:h file-pattern` for more examples
      --   "BufReadPre path/to/my-vault/*.md",
      --   "BufNewFile path/to/my-vault/*.md",
    -- },

    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = { enable = false },

      workspaces = {
        {
          name = "notes",
          path = "~/Documents/Notes/",
        },
      },

      new_notes_location = "current_dir"
    },
  },

  {
    "oflisback/obsidian-bridge.nvim",
    opts = {
      obsidian_server_address = "https://127.0.0.1:27124",
      cert_path = "~/.ssl/obsidian.crt",
      scroll_sync = true
    },
    event = {
      "BufReadPre *.md",
      "BufNewFile *.md",
    },
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      preset = 'obsidian',
      latex = {
        enabled = true,
        position = 'center',
      },
      completions = {
        lsp = { enabled = true }
      },
    }
  }
}
