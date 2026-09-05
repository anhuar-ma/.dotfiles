-- lua/plugins/dap/go.lua
-- Go: delve (via nvim-dap-go).

return {
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      -- nvim-dap-go drives `dlv` from PATH / Mason and registers Launch, Attach,
      -- "Debug test" and "Debug last test" configurations automatically.
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote (Delve :38697)",
          mode = "remote",
          request = "attach",
        },
      },
      delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = "",
      },
    },
  },
}
