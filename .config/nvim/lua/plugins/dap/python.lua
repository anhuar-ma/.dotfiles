-- lua/plugins/dap/python.lua
-- Python: debugpy (via nvim-dap-python for sensible defaults).

return {
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap_python = require("dap-python")

      -- Prefer the debugpy that Mason installed into its own virtualenv; fall
      -- back to a python3 on PATH otherwise.
      local mason_debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      local python_path = vim.uv.fs_stat(mason_debugpy) and mason_debugpy or "python3"

      dap_python.setup(python_path)

      -- Use the active virtualenv's interpreter for the debuggee when present.
      dap_python.resolve_python = function()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv then
          return venv .. "/bin/python"
        end
        return python_path
      end

      local dap = require("dap")
      table.insert(dap.configurations.python, {
        type = "python",
        request = "attach",
        name = "Attach remote (host:port)",
        connect = function()
          local host = vim.fn.input("Host [127.0.0.1]: ")
          host = host ~= "" and host or "127.0.0.1"
          local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
          return { host = host, port = port }
        end,
      })
    end,
  },
}
