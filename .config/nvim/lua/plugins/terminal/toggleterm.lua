-- lua/plugins/terminal/toggleterm.lua
-- Terminal integration via toggleterm.nvim plus a few native-terminal
-- ergonomics. Provides floating/horizontal/vertical terminals, dedicated
-- lazygit / node / python REPL terminals, and sane terminal-mode mappings
-- so you never get trapped in a terminal buffer.
--
-- The <leader>t which-key group label is registered in
-- lua/plugins/editing/which-key.lua.

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "ToggleTermToggleAll", "TermExec" },
    keys = {
      -- Primary toggle. <C-\> is the conventional toggleterm trigger and works
      -- in both normal and terminal mode (the terminal-mode map is set below).
      { [[<C-\>]], desc = "Toggle Terminal" },
      { "<leader>tf", desc = "Terminal (float)" },
      { "<leader>th", desc = "Terminal (horizontal)" },
      { "<leader>tv", desc = "Terminal (vertical)" },
      { "<leader>tt", desc = "Terminal (toggle)" },
      { "<leader>tg", desc = "Lazygit" },
      { "<leader>tn", desc = "Node REPL" },
      { "<leader>tp", desc = "Python REPL" },
    },
    opts = {
      -- Open/close with <C-\>. open_mapping wires the toggle in normal mode.
      open_mapping = [[<C-\>]],
      -- Slightly slower than default for a smoother slide-in animation.
      shading_factor = 2,
      -- Persist terminal size across toggles.
      persist_size = true,
      -- Reuse the same terminal when re-opened from a normal buffer.
      persist_mode = true,
      -- Default layout; per-terminal direction is overridden by the keymaps.
      direction = "float",
      -- Start in insert mode so you can type immediately.
      start_in_insert = true,
      -- Close the terminal buffer when the process exits cleanly.
      close_on_exit = true,
      -- Inherit the editor colorscheme inside the terminal window.
      autochdir = false,
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.85)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        winblend = 3,
      },
      -- Dynamic size for split terminals: 40% height horizontally,
      -- 40% width vertically.
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.4)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
        return 20
      end,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local Terminal = require("toggleterm.terminal").Terminal

      ------------------------------------------------------------------------
      -- Terminal-mode mappings: make navigating out of a terminal painless.
      -- These only apply to `term://` buffers via the autocmd below.
      ------------------------------------------------------------------------
      local function set_terminal_keymaps()
        local map_opts = { buffer = 0, silent = true }
        -- <Esc> / jk to leave terminal (insert) mode.
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], map_opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], map_opts)
        -- Window navigation straight from terminal mode.
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], map_opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], map_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], map_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], map_opts)
        -- Re-toggle from inside the terminal.
        vim.keymap.set("t", [[<C-\>]], [[<Cmd>ToggleTerm<CR>]], map_opts)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = set_terminal_keymaps,
        desc = "Set toggleterm terminal-mode keymaps",
      })

      ------------------------------------------------------------------------
      -- Dedicated, lazily-created terminals.
      ------------------------------------------------------------------------
      local lazygit = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        hidden = true,
        float_opts = { border = "curved" },
        -- Disable the toggleterm count so lazygit's own gg/G etc. work.
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.keymap.set("t", "q", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
        end,
      })

      local node = Terminal:new({ cmd = "node", direction = "float", hidden = true })
      local python = Terminal:new({ cmd = "python3", direction = "float", hidden = true })

      ------------------------------------------------------------------------
      -- <leader>t* keymaps. <leader>t is the terminal group (see which-key).
      ------------------------------------------------------------------------
      local map = vim.keymap.set
      map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal (float)" })
      map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal (horizontal)" })
      map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal (vertical)" })
      map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Terminal (toggle)" })

      map("n", "<leader>tg", function()
        lazygit:toggle()
      end, { desc = "Lazygit" })
      map("n", "<leader>tn", function()
        node:toggle()
      end, { desc = "Node REPL" })
      map("n", "<leader>tp", function()
        python:toggle()
      end, { desc = "Python REPL" })
    end,
  },
}
