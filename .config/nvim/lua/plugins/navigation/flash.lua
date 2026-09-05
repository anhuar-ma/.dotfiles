-- lua/plugins/navigation/flash.lua
-- flash.nvim is shipped by LazyVim with the standard s/S/r/R keymaps.
-- This spec only overrides opts: a custom (Colemak-friendly) label set,
-- rainbow labels, and enabling flash labels on the f/t/F/T and search motions.

return {
  {
    "folke/flash.nvim",
    opts = {
      labels = "asetnioudhrlmwfpgycv",
      label = {
        uppercase = false,
        rainbow = { enabled = true, shade = 5 },
      },
      modes = {
        char = { jump_labels = true }, -- label f/t/F/T jumps
        search = { enabled = true }, -- label / and ? matches
      },
    },
  },
}
