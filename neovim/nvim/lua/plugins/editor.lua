return {
  ---@todo perhaps consider adding preview to the actual buffer like other plugins do
  ---@todo highlights
  ---@todo set styling not of cursor but of entire line
  ---@todo jump to last branching
  ---@todo Set title
  ---@todo Change styling of path to more easily show connections
  ---@todo Folding
  {
    "XXiaoA/atone.nvim",
    cmd = "Atone",

    config = function ()
      require('atone').setup({
        ui = {
          compact = true
        },

        auto_attach = {
          enabled=false
        }
      })

      vim.keymap.set("", "<leader>u", function() require('atone.core').toggle() end, {desc="Toggle Undotree"})
    end
  }
}
