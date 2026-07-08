return {
  ---@todo Customize codediff more
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",

    opts = {
      diff = {
        compute_moves = true
      }
    },

    keys = {
      { "<leader>g" }
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = { }
  }
}
