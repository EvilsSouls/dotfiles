return {
  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "fish", "html", "javascript", "json", "jsonc", "toml", "javascript", "latex", "yaml" },
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<Leader>tv",
        node_incremental = "<Leader>ti",
        scope_incremental = "<Leader>ts",
        node_decremental = "<Leader>td"
      }
    },
    indentation = {
      enable = true
    }
  }
}
