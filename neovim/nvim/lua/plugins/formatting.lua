return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<C-0>',
      function()
        local callback = nil
        -- local prev_lines = vim.api.nvim_buf_line_count(0)
        if vim.api.nvim_get_mode().mode == 'i' then
          local normal_key = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
          vim.api.nvim_feedkeys(normal_key, 'n', false)

          callback = function()
            vim.api.nvim_feedkeys('a', 'n', false)
            -- local new_lines = vim.api.nvim_buf_line_count(0)
            -- vim.api.nvim_win_set_cursor
          end
        end

        require('conform').format({ async = true }, callback)
      end,
      mode = { 'i', 'n' },
      desc = 'Format buffer',
    },
  },

  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      javascript = { 'prettier' },
      yaml = { 'prettier' },
      html = { 'prettier' },
      markdown = { 'rumdl' },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = 'fallback',
    },
    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 500,
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        append_args = { '-i', '2' },
      },
    },
  },

  init = function()
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
}
