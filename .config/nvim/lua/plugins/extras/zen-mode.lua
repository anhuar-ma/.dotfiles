-- lua/plugins/extras/zen-mode.lua
-- zen-mode: a clean, distraction-free editing window. Centers the buffer,
-- hides UI chrome, and can dim non-active windows. Pairs with twilight.

return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode (toggle)" },
    },
    opts = {
      window = {
        backdrop = 0.95, -- shade the rest of the editor (1 = no dimming)
        width = 0.75, -- 75% of the editor width (use a float for %, int for columns)
        height = 1, -- full height
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          foldcolumn = "0", -- disable fold column
          list = false, -- disable whitespace listchars
        },
      },
      plugins = {
        -- Turn off distractions while in Zen mode; restored on exit.
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0, -- hide the statusline
        },
        twilight = { enabled = true }, -- dim inactive code via twilight
        gitsigns = { enabled = false }, -- hide git signs
        tmux = { enabled = false }, -- don't touch tmux statusline by default
      },
      on_open = function()
        -- Optional: stop the cursorline blink/jump from being noticeable.
        vim.opt.scrolloff = 999
      end,
      on_close = function()
        vim.opt.scrolloff = 8
      end,
    },
  },
}
