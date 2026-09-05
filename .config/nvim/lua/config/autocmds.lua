-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

local autocmd = vim.api.nvim_create_autocmd

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Auto-save all active files (no autoformat)                     │
-- │ LazyVim does not auto-save. This saves lazily on context       │
-- │ switch (FocusLost / BufLeave / WinLeave) like `:wall`, across   │
-- │ every modified buffer, using `noautocmd write` so it does NOT  │
-- │ trigger BufWritePre and therefore never runs LazyVim's         │
-- │ format-on-save.                                                │
-- ╰──────────────────────────────────────────────────────────────╯
local function should_autosave(buf)
  return vim.bo[buf].modified
    and vim.bo[buf].modifiable
    and not vim.bo[buf].readonly
    and vim.bo[buf].buftype == "" -- skip terminals, help, quickfix, etc.
    and vim.api.nvim_buf_get_name(buf) ~= "" -- skip unnamed [No Name] buffers
end

autocmd({ "FocusLost", "BufLeave", "WinLeave" }, {
  group = augroup("auto_save"),
  desc = "Auto-save all modified buffers on context switch (no autoformat)",
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and should_autosave(buf) then
        vim.api.nvim_buf_call(buf, function()
          -- `noautocmd` skips BufWritePre -> no conform/LSP formatting.
          vim.cmd("silent! noautocmd write")
        end)
      end
    end
  end,
})

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Terminal buffer UI                                             │
-- │ Disable line numbers / sign column / spell in :terminal        │
-- │ buffers for a cleaner shell experience.                        │
-- ╰──────────────────────────────────────────────────────────────╯
autocmd("TermOpen", {
  group = augroup("term_settings"),
  desc = "Tune terminal buffer UI",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.spell = false
  end,
})

-- ╭──────────────────────────────────────────────────────────────╮
-- │ Neorg: treesitter folding + indentation                       │
-- │ Neorg ships its own treesitter grammar; enable it (with fold   │
-- │ and indent expressions) for .norg buffers. Guarded by pcall    │
-- │ so it is a no-op until the neorg grammar is installed.         │
-- ╰──────────────────────────────────────────────────────────────╯
autocmd("FileType", {
  group = augroup("neorg_treesitter"),
  desc = "Enable treesitter folding/indent for Neorg buffers",
  pattern = { "norg", "neorg" },
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- ╭──────────────────────────────────────────────────────────────╮
-- │ C / C++: marker folding                                        │
-- │ Use {{{ }}} marker folds for C/C++ (the cpp templates wrap     │
-- │ their helper headers in markers). foldlevel=0 closes those     │
-- │ marker blocks on open while leaving the rest of the file       │
-- │ visible. Migrated from the previous config.                    │
-- ╰──────────────────────────────────────────────────────────────╯
autocmd("FileType", {
  group = augroup("cpp_marker_fold"),
  desc = "Marker folding for C/C++ buffers",
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldenable = true
    vim.opt_local.foldlevel = 0
  end,
})
