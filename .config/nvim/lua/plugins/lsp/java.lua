-- lua/plugins/lsp/java.lua
-- Java: nvim-jdtls (richer than plain lspconfig for Eclipse JDTLS).
-- lspconfig is told not to start jdtls directly (see lua/plugins/lsp/servers/java.lua).

return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = { "java" },
    opts = function()
      return {
        -- Build a project-local root pattern for multi-module Java repos
        root_dir = (vim.fs.root or require("lspconfig.util").root_pattern)(0, {
          ".git",
          "mvnw",
          "gradlew",
          "pom.xml",
          "build.gradle",
        }),
        settings = {
          java = {
            inlayHints = {
              parameterNames = { enabled = "all" },
            },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.Assert.*",
                "org.mockito.Mockito.*",
                "java.util.Objects.requireNonNull",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      local jdtls_ok, jdtls = pcall(require, "jdtls")
      if not jdtls_ok then
        return
      end

      local function start_jdtls()
        local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
        local config = {
          cmd = { vim.fn.exepath("jdtls") ~= "" and "jdtls" or (mason_path .. "/bin/jdtls") },
          root_dir = opts.root_dir,
          settings = opts.settings,
        }
        jdtls.start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        group = vim.api.nvim_create_augroup("jdtls_attach", { clear = true }),
        callback = start_jdtls,
      })

      -- Attach immediately for the buffer that triggered loading
      if vim.bo.filetype == "java" then
        start_jdtls()
      end
    end,
  },
}
