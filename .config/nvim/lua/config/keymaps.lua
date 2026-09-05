-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ── Centered scrolling / search (LazyVim doesn't center these) ──────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down (centered)", silent = true })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up (centered)", silent = true })
map("n", "n", "nzzzv", { desc = "Next Search Result (centered)", silent = true })
map("n", "N", "Nzzzv", { desc = "Prev Search Result (centered)", silent = true })
map("n", "*", "*zzzv", { desc = "Search Word Forward (centered)", silent = true })
map("n", "#", "#zzzv", { desc = "Search Word Backward (centered)", silent = true })

-- Join lines without moving the cursor to the end of the line.
map("n", "J", "mzJ`z", { desc = "Join Lines (keep cursor)", silent = true })

-- ── Clipboard ergonomics ────────────────────────────────────────────────────
-- Paste over a visual selection WITHOUT clobbering the unnamed register.
map("x", "<leader>p", [["_dP]], { desc = "Paste (keep register)", silent = true })
-- Explicit system-clipboard yank/delete.
map({ "n", "x" }, "<leader>y", [["+y]], { desc = "Yank to clipboard", silent = true })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to clipboard", silent = true })
map({ "n", "x" }, "<leader>D", [["_d]], { desc = "Delete to void register", silent = true })
-- Select the entire buffer.
map("n", "<leader>A", "ggVG", { desc = "Select All", silent = true })

-- ── Misc productivity ───────────────────────────────────────────────────────
-- Make the current file executable (handy for scripts).
map("n", "<leader>cx", "<cmd>!chmod +x %<cr>", { desc = "Make File Executable" })
-- Source the current Lua file (quick config iteration).
map("n", "<leader>cR", "<cmd>source %<cr>", { desc = "Source Current File", silent = true })
-- Insert a timestamp at the cursor.
map("i", "<C-t>", function()
  return os.date("%Y-%m-%d %H:%M")
end, { expr = true, desc = "Insert Timestamp" })
