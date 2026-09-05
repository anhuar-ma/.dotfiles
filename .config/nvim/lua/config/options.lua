-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- Force Neovim to use the native OSC 52 support
-- This overrides xclip/wl-copy detection which fails over SSH
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--   },
--   paste = {
--     ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
--   },
-- }
--
-- vim.opt.clipboard = "unnamedplus"

local opt = vim.opt
local g = vim.g

-- ── Overrides of LazyVim defaults ───────────────────────────────────────────
opt.inccommand = "split" -- LazyVim uses "nosplit"; prefer the split preview
opt.scrolloff = 8 -- LazyVim uses 4; keep more context around the cursor
opt.numberwidth = 2 -- narrower gutter (LazyVim leaves the default of 4)
-- Custom fold glyphs (LazyVim uses arrows " "/" "); full table since
-- `fillchars` is replaced wholesale, not merged.
opt.fillchars = {
  foldopen = "▾",
  foldclose = "▸",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- ── Additions not configured by LazyVim ─────────────────────────────────────
opt.gdefault = true -- :substitute is global on a line by default
opt.softtabstop = 2 -- <Tab>/<BS> operate on 2-space stops
opt.breakindent = true -- wrapped lines keep their indent
opt.foldlevelstart = 99 -- start with all folds open in newly opened buffers
opt.equalalways = false -- don't auto-equalize window sizes on split changes
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Undo / no-swap workflow (undofile is on via LazyVim; customize location and
-- disable swap/backup since persistent undo + auto-save cover recovery).
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Performance knobs for large files / fast escape.
opt.ttimeoutlen = 10 -- near-instant <Esc> out of insert mode
opt.redrawtime = 1500 -- cap syntax redraw time on big files
opt.synmaxcol = 300 -- don't highlight extremely long lines

-- Disable unused language providers to trim startup.
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
