-- Don't forget to split into multiple modules! Configuration could go under plugins/configuration/rainbow-delimiters-nvim. Also don't forget to change lualine to be better + add Lazy.nvim component
-- Also don't forget to change Markdown Rendering, so that it only renders when in Normal, Command / other modes

return {
  "tpope/vim-surround",

  "neovim/nvim-lspconfig",

  "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "fish", "html", "javascript", "json", "jsonc", "toml", "javascript", "latex", "yaml" },
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm"
      }
    },
    indentation = {
      enable = true
    }
  },

  {
     "mason-org/mason.nvim",
     opts = {}
  },

  {
    "folke/tokyonight.nvim",
    opts = {}
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'tokyonight-night',
      sections = {
        lualine_c = {
          {'filename', path = 1, symbols = {modified = ''}},
          {'diff', seperator = ''}
        },
        lualine_y = {
          {'filesize', icon = ''}
        },
        lualine_z = {
          { 'datetime', style = '%H:%M', icon = '' }
        }
      }
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    --- @module "ibl"
    --- @type ibl.config
    opts = {
      indent = {
        char = "▏"
      }
    }
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
        enabled = true
      },
      completions = {
        lsp = { enabled = true }
      },
      code = {
        position = 'left'
      }
    }
  },

  {
    'norcalli/nvim-colorizer.lua',
    opts = {
      html = {
        mode = 'foreground'
      }
    }
  }
}
