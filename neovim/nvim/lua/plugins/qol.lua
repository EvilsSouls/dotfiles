return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "folke/which-key.nvim",
    config = function ()
      local wk = require('which-key')

      wk.setup({
        preset = "helix",

        ---@type wk.Spec
        spec = {
          { "<leader>t", group = "Options", icon = {icon=" ", color=azure}},
          { "<leader>f", group = "Fuzzy Finding", icon = {icon="󰭎 ", color=purple}}
        },

        icons = {
          keys = {
            C = "󰯱 ",
            M = "󰯫 ",
            D = "󰌽 "
          }
        }
      })

      vim.keymap.set(
        'n', '<leader>?',
        function() require("which-key").show({ global = false }) end,
        {desc="Buffer Local Keymaps (which-key)"}
      )
    end,
  },

  {
    'numToStr/Comment.nvim',
    opts = {}
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      enable_rename = false
    }
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    config = function ()
      ---@type rainbow_delimiters.config
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = 'rainbow-delimiters.strategy.global',
          vim = 'rainbow-delimiters.strategy.local',
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
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
    'catgoose/nvim-colorizer.lua',
    event = "BufReadPre",
    opts = {
      filetypes = {
        "*",
        css = { css = true },
        html = { tailwind = true, css = true },
        scss = { css = true, scss = true, }
      },

      options = {
        parsers = {
          hex = {rrggbbaa = true},
          xterm = {enable = true},
          xcolor = {enable = true},
          css_var = {parsers = {
            css = true,
            css_fn = true,
            css_color = true
          }},
        },

        display = {
          mode = { "virtualtext", "underline" },
          virtualtext = { position = "before", char = "󱓻"}
        },
      }

      --[[ css = {
        mode = 'foreground',
        css = true,
        css_fn = true,
        rgb_fn = true,
        hsl_fn = true,
      },
      html = {
        mode = 'foreground',
        css = true,
        css_fn = true,
        rgb_fn = true,
        hsl_fn = true,
      } ]]
    }
  },

  {
    'https://github.com/nvzone/minty',
    dependencies = {'nvchad/volt'},
    cmd = { "Shades", "Huefy" },
  },

  {'mluders/comfy-line-numbers.nvim', opts = {}},

  {
    'lewis6991/gitsigns.nvim',
    opts = {}
  }
}
