-- lua/plugins/lsp/mason.lua
-- mason.nvim is shipped by LazyVim. This spec only appends the extra
-- formatters/linters used by the configured languages (LazyVim already
-- installs stylua and the servers declared in opts.servers; DAP adapters are
-- handled in dap/dap-core.lua). lazy.nvim merges this into LazyVim's
-- ensure_installed list.

return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "selene", -- Lua linter
        "luacheck", -- Lua linter
        "shfmt", -- shell formatter
        "gofumpt", -- Go formatter
        "goimports", -- Go imports
        "prettierd", -- JS/TS/JSON/MD formatter
        "eslint_d", -- JS/TS linter
      })
      return opts
    end,
  },
}
