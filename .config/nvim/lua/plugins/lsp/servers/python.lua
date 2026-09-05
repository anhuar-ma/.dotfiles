-- lua/plugins/lsp/servers/python.lua
-- Python LSP: pyright for type checking + ruff for lint/code actions
-- (hover handed off to pyright).

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
              },
            },
          },
        },
        ruff = {
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end,
          init_options = {
            settings = { organizeImports = true },
          },
        },
      },
    },
  },
}
