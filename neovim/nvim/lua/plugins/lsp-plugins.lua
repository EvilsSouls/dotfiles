return {
  "neovim/nvim-lspconfig",

  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "clangd", "lua_ls", "rust_analyzer", "fish_lsp", "pyright", "vtsls" }
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    }
  }
}
