return {
  {
    "paradoxical-dev/zeal.nvim",
    event = "VeryLazy",
    opts = {
      use_toggleterm = true,
      toggleterm = {
        toggle_map = "<leader>hh"
      },
      picker = {
        type = "snacks"
      },
      ft_map = {
        py = { "Manim" }
      },
    }
  }
}
