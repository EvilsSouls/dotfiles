return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- lazy = false,
    ---@module "fzf-lua"
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {},
    ---@diagnostic enable: missing-fields
    keys = {
      -- fzf keybindings
      { "<leader>f<space>", function() require('fzf-lua').resume() end,               desc = "Resume last query"                 },
      { "<leader>fz",       function() require('fzf-lua').zoxide() end,               desc = "Change directory using Zoxide"     },
      { "<leader>fd",       function() require('fzf-lua').files() end,                desc = "Find File"                         },
      { "<leader>fs",       function() require('fzf-lua').grep() end,                 desc = "Search inside Files"               },
      { "<leader>fe",       function() require('fzf-lua').global() end,               desc = "Select Files, Buffers and Symbols" },
      { "<leader>fj",       function() require('fzf-lua').lsp_document_symbols() end, desc = "Search Symbols"                    },
      { "<leader>ff",       function() require('fzf-lua').lsp_finder() end,           desc = "Search through all LSP locations"  },
      { "<leader>fb",       function() require('fzf-lua').buffers() end,              desc = "Select Buffer"                     },
      { "<leader>fh",       function() require('fzf-lua').history() end,              desc = "Traverse Opened File History"      },
      { "<leader>ft",       function() require('fzf-lua').tabs() end,                 desc = "Select Tab"                        },
      { "<leader>f/",       function() require('fzf-lua').search_history() end,       desc = "Traverse search history"           },
      { "<leader>f:",       function() require('fzf-lua').command_history() end,      desc = "Traverse command history"          },
      { "<leader>fg",       function() require('fzf-lua').help_tags() end,            desc = "Traverse help tags"                },
      { "<leader>fm",       function() require('fzf-lua').marks() end,                desc = "Traverse marks"                    },
      { "<leader>fr",       function() require('fzf-lua').registers() end,            desc = "Pick register"                     },
      { "<leader>fk",       function() require('fzf-lua').keymaps() end,              desc = "Search keymaps"                    },
      { "<leader>fo",       function() require('fzf-lua').nvim_options() end,         desc = "Search options"                    },
      { "<leader>f<cr>",    function() require('fzf-lua').builtin() end,              desc = "Pick builtin Command"              },
    }
  }
}
