-- lua/plugins/lsp/web.lua
-- Web/front-end language servers: emmet, tailwindcss, and cssls. Migrated
-- from the previous config.
--
-- Declaring servers under `opts.servers` is enough — LazyVim installs them
-- via mason-lspconfig and calls setup automatically, so no separate
-- ensure_installed block is needed.
--
-- (Fixes the old config bug where emmet was set up via a top-level
-- require("lspconfig").emmet_language_server.setup() call that ran at import
-- time.)

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Emmet abbreviations across HTML/JSX/CSS-family filetypes.
        emmet_language_server = {
          filetypes = {
            "css",
            "eruby",
            "html",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "pug",
            "typescriptreact",
          },
          init_options = {
            showAbbreviationSuggestions = true,
            showExpandedAbbreviation = "always",
            showSuggestionsAsSnippets = false,
          },
        },
        -- Tailwind CSS IntelliSense.
        tailwindcss = {},
        -- Plain CSS/SCSS/LESS language server.
        cssls = {},
      },
    },
  },
}
