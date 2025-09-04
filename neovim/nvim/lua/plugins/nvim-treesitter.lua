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
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm"
      }
    },
    indentation = {
      enable = true
    }
  }
}
