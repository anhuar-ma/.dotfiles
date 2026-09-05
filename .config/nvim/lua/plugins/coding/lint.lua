-- lua/plugins/coding/lint.lua
-- nvim-lint is shipped by LazyVim, which sets the trigger events
-- (BufWritePost/BufReadPost/InsertLeave) and the lint runner/config. This
-- spec only adds the per-filetype linters; LazyVim deep-merges linters_by_ft.

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        sh = { "shellcheck" },
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
      },
    },
  },
}
