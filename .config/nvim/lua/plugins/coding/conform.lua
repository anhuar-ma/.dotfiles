-- lua/plugins/coding/conform.lua
-- conform.nvim is shipped by LazyVim, which registers it as the primary
-- formatter and wires format-on-save itself. IMPORTANT: do NOT set
-- `format_on_save`/`format_after_save` here — LazyVim emits a warning and
-- ignores them. LazyVim's defaults already include lua=stylua, sh=shfmt,
-- fish=fish_indent, and the `injected` formatter.
--
-- This spec only adds per-filetype formatters LazyVim doesn't define.

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff_organize_imports" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        go = { "gofumpt", "goimports" },
        rust = { "rustfmt" },
      },
    },
  },
}
