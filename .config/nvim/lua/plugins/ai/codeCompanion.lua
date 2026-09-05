return {
  "olimorris/codecompanion.nvim",
  -- version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = "n", desc = "Toggle CodeCompanion Chat" },
    { "<leader>aa", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to CodeCompanion Chat" },
  },
  -- config = function(_, opts)
  --   require("codecompanion").setup(opts)
  --
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "CodeCompanionChatCreated",
  --     callback = function(args)
  --       local chat = require("codecompanion").buf_get_chat(args.data.bufnr)
  --       if not chat or not chat.buffer_context or not chat.buffer_context.bufnr then
  --         return
  --       end
  --
  --       local bufnr = chat.buffer_context.bufnr
  --       if
  --         vim.api.nvim_buf_is_valid(bufnr)
  --         and vim.bo[bufnr].buftype == ""
  --         and vim.api.nvim_buf_get_name(bufnr) ~= ""
  --       then
  --         local EditorContext = require("codecompanion.interactions.shared.editor_context.buffer")
  --         EditorContext.new({ Chat = chat }):chat_render({ bufnr = bufnr })
  --       end
  --     end,
  --   })
  -- end,
  opts = {
    adapters = {
      http = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "cmd:secret-tool lookup api gemini",
            },
            schema = {
              model = {
                -- default = "gemini-flash-latest", -- or "gemini-flash-latest","gemini-3.1-flash-lite-preview",
                default = "gemini-3.1-flash-lite-preview", -- or "gemini-flash-latest","gemini-3.1-flash-lite-preview",
              },
              thinkingLevel = {
                default = "low", -- "low" | "medium" | "high" | "none"
              },
            },
          })
        end,
      },
    },
    interactions = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
      cmd = {
        adapter = "gemini",
      },
    },
  },
}
