---@type ChadrcConfig
local M = {}

-- Toggle NvimTree (Neotree) with 'e' key
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Set autochdir to synchronize the working directory with the current file
vim.o.autochdir = 1 
M.ui = { 
  theme = 'gatekeeper',
  transparency = true,
changed_themes = {
      gatekeeper = {
         base_30 = {
        grey_fg = "#959595",
         },
      },
   },
}

M.nvimtree = {
    git = {
        enable = true,
    },
    renderer = {
        highlight_git = true,
        icons = {
        show = {
            git = true,
            },
        },
    },
    view = {
        side = "right",
    },
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")
return M
