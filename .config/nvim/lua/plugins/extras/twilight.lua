-- lua/plugins/extras/twilight.lua
-- twilight: dims all code except the syntactic block under the cursor.
-- Useful standalone (focus on a function) and auto-enabled inside zen-mode.

return {
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight (toggle focus dim)" },
    },
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming (0 = fully dim, 1 = no dim)
        color = { "Normal", "#ffffff" },
        term_bg = "#000000",
        inactive = false, -- when true, dims other windows entirely
      },
      context = 10, -- amount of lines to keep visible around the cursor block
      treesitter = true, -- use treesitter to determine the dimmable block
      expand = { -- node types whose entire scope stays lit
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- filetypes for which twilight is disabled
    },
  },
}
