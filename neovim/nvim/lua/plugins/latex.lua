return {
  {
    enabled = false,
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    init = function()
      vim.g.vimtex_view_method = 'zathura_simple'

      -- Cleanup on quit
      vim.api.nvim_create_autocmd("User", {
        pattern = "VimtexEventQuit",
        group = au_group,
        command = "VimtexClean"
      })

      -- Focus the terminal after inverse search
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VimtexEventViewReverse',
        group = au_group,
        command = "call b:vimtex.viewer.xdo_focus_vim()"
      })
    end
  }
}
