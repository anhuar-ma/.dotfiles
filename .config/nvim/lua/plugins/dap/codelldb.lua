-- lua/plugins/dap/codelldb.lua
-- CodeLLDB adapter for native-compiled languages: C, C++, and Rust.
--
-- This MUST be a single nvim-dap `config` hook (not split per language and not
-- via `opts`):
--   * nvim-dap has no setup() function, so attaching `opts` makes lazy.nvim
--     call require("dap").setup(opts) and error
--     ("attempt to call field 'setup' (a nil value)").
--   * lazy.nvim resolves a plugin's `config` function from a single fragment
--     (last one wins via metatable), so two files each adding a `config` to
--     nvim-dap would silently clobber each other. Hence cpp + rust + c share
--     this one file.
--
-- The codelldb binary is installed by Mason (see dap/dap-core.lua's
-- mason-nvim-dap ensure_installed).

return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    config = function()
      local dap = require("dap")

      -- Resolve the codelldb binary from Mason, falling back to PATH.
      local mason_root = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension"
      local codelldb_bin = mason_root .. "/adapter/codelldb"
      if not vim.uv.fs_stat(codelldb_bin) then
        codelldb_bin = "codelldb"
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_bin,
          args = { "--port", "${port}" },
        },
      }

      -- ── C / C++ ────────────────────────────────────────────────────────
      local cpp_configs = {
        {
          -- CP helper: compile the current file with -g -O0 + sanitizers right
          -- before launch (abort on compile error), then debug. First entry so
          -- it is the default pick for competitive-programming files.
          name = "CP: build & debug current file",
          type = "codelldb",
          request = "launch",
          program = function()
            local src = vim.fn.expand("%:p")
            local exe = vim.fn.expand("%:p:r") -- path minus extension
            local out = vim.fn.system({
              "g++",
              "-std=c++23",
              "-g",
              "-O0",
              "-fsanitize=address,undefined",
              src,
              "-o",
              exe,
            })
            if vim.v.shell_error ~= 0 then
              vim.notify(out, vim.log.levels.ERROR, { title = "Compile failed" })
              return dap.ABORT
            end
            return exe
          end,
          cwd = "${fileDirname}",
          stopOnEntry = false,
        },
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Attach to process",
          type = "codelldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.cpp = cpp_configs
      dap.configurations.c = cpp_configs

      -- ── Rust ───────────────────────────────────────────────────────────
      dap.configurations.rust = {
        {
          name = "Launch executable",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Attach to process",
          type = "codelldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
