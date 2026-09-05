-- lua/plugins/lsp/servers/lua.lua
-- lua_ls settings. Declaring a server under opts.servers is enough for
-- LazyVim to install it via mason and call setup. lazy.nvim deep-merges this
-- with LazyVim's nvim-lspconfig defaults and the other per-server specs.

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              codeLens = { enable = true },
              completion = { callSnippet = "Replace" },
              doc = { privateName = { "^_" } },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
      },
    },
  },
}
