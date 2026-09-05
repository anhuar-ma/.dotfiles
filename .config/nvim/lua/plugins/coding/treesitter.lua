-- lua/plugins/coding/treesitter.lua
-- nvim-treesitter is shipped by LazyVim with highlight/indent/folds enabled and
-- a broad default parser list (bash, c, diff, html, javascript, jsdoc, json,
-- lua, luadoc, luap, markdown, markdown_inline, python, query, regex, toml,
-- tsx, typescript, vim, vimdoc, yaml, ...). The move/select text-object
-- keymaps are provided by LazyVim's nvim-treesitter-textobjects spec.
--
-- LazyVim uses `opts_extend = { "ensure_installed" }`, so the parsers below
-- are APPENDED to its default list. Only the languages LazyVim doesn't already
-- install are listed here.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "java",
        "jsonc",
        "rust",
      },
    },
  },
}
