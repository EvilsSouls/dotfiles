return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- transparent = true,
      -- terminal_colors = false,

      -- Colors created, by mixing 0.23 full black with original colors found at
      -- https://github.com/folke/tokyonight.nvim/blob/cdc07ac78467a233fd62c493de29a17e0cf2b2b6/extras/lua/tokyonight_night.lua
      -- using the following command
      -- `pastel mix -s OkLab -f 0.23 "#000000" "#1a1b26" "#16161e" "#0C0E14" "#16161e" "#292e42" "#16161e" "#3d59a1" "#16161e" "#16161e" "#283457"`
      -- However there are still a lot of utilities that tokyonight automatically creates colors for, that have not been updated.
      ---@todo perhaps create a utility to automatically generate this function, while also actually replacing every occurence of these
      --- base colors with their darkened counterpart (to get compatibility with other plugins such as Blink)
      on_colors = function(colors)
        colors.bg = "#0F1018"
        colors.bg_dark = "#0C0C12"
        colors.bg_dark1 = "#06070B"
        colors.bg_float = "#0c0c12"
        colors.bg_highlight = "#1a1d2c"
        colors.bg_popup = "#0c0c12"
        colors.bg_search = "#283c70"
        colors.bg_sidebar = "#0c0c12"
        colors.bg_statusline = "#0c0c12"
        colors.bg_visual = "#19223b"
      end,
      -- Doesn't look good, since currently, I can only make seven colors transparent
      -- on_highlights = function (highlights)
      --   highlights.Folded = {
      --     bg = "#272c42"
      --   }
      -- end
    },

    init = function()
      -- Set Color Scheme to Tokyonight
      vim.cmd[[colorscheme tokyonight-night]]
    end
  },
}
