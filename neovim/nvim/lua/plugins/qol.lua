return {
  "tpope/vim-surround",

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
      html = {
        mode = 'foreground'
      }
    }
  }
}
