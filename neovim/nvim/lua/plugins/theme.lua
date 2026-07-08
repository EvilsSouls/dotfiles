return {
  "folke/tokyonight.nvim",
  priority = 1000,
  lazy = false,
  ---@todo Make toggle functions to toggle terminal transparency.
  --- Perhaps also make changing the darkening of colors also chane the values that the terminal makes transparent
  --- so that there are two independent toggles: darkening of background and transparency of terminal
  config = function()
    require('tokyonight').setup(
      ---@class tokyonight.Config
      ---@field on_colors fun(colors: ColorScheme)
      ---@field on_highlights fun(highlights: tokyonight.Highlights, colors: ColorScheme)
      {
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
      }
    )

    -- Set Color Scheme to Tokyonight
    vim.cmd[[colorscheme tokyonight-night]]

    -- Set keybindings for switching between different modes of the theme
    vim.keymap.set(
      "n",
      "<leader>Ttf",
      function()
        local current_options = require('tokyonight.config').options
        local new_val = not(current_options.transparent)
        current_options.transparent = new_val

        vim.notify("Set built-in transparency to " .. tostring(new_val))
        print("Transparency:", current_options.transparent)

        -- Refresh colorscheme
        require('tokyonight').setup(current_options)
        vim.cmd.colorscheme('tokyonight-night')
      end,
      {desc="Toggle tokyonight's built-in transparency setting"}
    )

    vim.keymap.set(
      "n",
      "<leader>Ttd",
      function()
        ---@class tokyonight.Config
        local current_options = require('tokyonight.config').options

        if current_options.on_colors_backup == nil then
          vim.notify("Set background back to normal")
          current_options.on_colors_backup = current_options.on_colors
          current_options.on_colors = function(colors) end
        else
          vim.notify("Darkened the background")
          current_options.on_colors = current_options.on_colors_backup
          current_options.on_colors_backup = nil
        end

        require('tokyonight').setup(current_options)
        vim.cmd.colorscheme('tokyonight-night')
      end,
      {desc="Toggle the color overrides darkening the backgrounds"}
    )
  end
}
