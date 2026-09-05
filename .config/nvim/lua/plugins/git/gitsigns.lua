-- lua/plugins/git/gitsigns.lua
-- gitsigns is shipped by LazyVim with the gutter signs and the full
-- on_attach hunk keymaps (]h/[h, <leader>gh*, ih text object, toggles).
-- This spec only adds what LazyVim leaves off by default: inline
-- current-line blame.

return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    },
  },
}
