local function toggle_typst_preview_follow_cursor()
  local tp = require('typst-preview')
  tp.set_follow_cursor(not tp.get_follow_cursor())
end

return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  version = '1.*',
  opts = {
    open_cmd = 'qutebrowser --target private-window %s',

    dependencies_bin = {
      tinymist = 'tinymist'
    }
  },
  keys = {
    { "<localleader>tt", "<cmd>TypstPreviewToggle<cr>", desc = "Toggle the Typst Preview" },
    { "<localleader>tc", toggle_typst_preview_follow_cursor, desc = "Toggle automatic synchronisation of preview and editor position" },
    { "<localleader>ts", function() require('typst-preview').sync_with_cursor() end, desc = "Sync position of preview and editor"}
  }
}
