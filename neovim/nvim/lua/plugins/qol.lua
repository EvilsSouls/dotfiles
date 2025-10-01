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
    opts = {},
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

  "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",

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
    'norcalli/nvim-colorizer.lua',
    opts = {
      '*',
      css = {
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
      }
    }
  }
}
