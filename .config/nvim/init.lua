-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.o.guifont = "JetBrainsMono Nerd Font:h39b"

require("config.lazy")
-- Lua
-- Lua
require("onedark").setup({
  -- Main options --
  style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  transparent = false, -- Show/hide background
  term_colors = false, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- toggle theme style ---
  toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = "italic",
    keywords = "none",
    functions = "bold",
    strings = "none",
    variables = "none",
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {
    bg0 = "#071022",
    fg = "#BDC8DB",
  }, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
})

require("onedark").load()

local function split_and_open()
  local function open_file(file)
    local path = vim.fn.getcwd() .. "/" .. file
    -- Check if the file exists; if not, create it.
    if vim.fn.filereadable(path) == 0 then
      local f = io.open(path, "w")
      if f then
        f:close()
      else
        print("Error creating file: " .. file)
        return
      end
    end
    -- Open the file in the current window.
    vim.cmd("edit " .. file)
  end

  -- Save the current window ID
  local current_win = vim.api.nvim_get_current_win()

  -- Step 1: Split horizontally and open 'out'
  vim.cmd("vsplit")
  open_file("out")

  -- Step 2: Split vertically and open 'in'
  vim.cmd("split")
  open_file("in")

  -- Step 3: Split horizontally, increase width, and open 'log'
  vim.cmd("vsplit")
  open_file("Log")

  -- Set focus back to the original window
  vim.api.nvim_set_current_win(current_win)
end

-- Map the function to a command for easy usage
vim.api.nvim_create_user_command("OpenTestCases", split_and_open, {})

local stdnumber = "20"

local function set_stdnumber(new_stdnumber)
  stdnumber = new_stdnumber
  print("Standard number set to: " .. stdnumber)
end

local function compile_current_cpp()
  vim.cmd("update")
  -- Get the current buffer name
  local cppfile = vim.fn.expand("%:p")

  -- Check if the file is a C++ file
  if not cppfile:match("%.cpp$") then
    print("Not a C++ file")
    return
  end

  vim.cmd("set noconfirm")
  -- Run the compile_cpp.sh script with the current C++ file and standard number
  local cmd = string.format("bash ~/.config/nvim/lua/scripts/compile_cpp.sh %s %s", cppfile, stdnumber)
  vim.fn.system(cmd)
  vim.cmd("let buf=bufnr('%') | exec 'bufdo e' | exec 'b' buf")
  vim.cmd("set confirm")

  -- Print the name of the current C++ file
  print("Compiled: " .. cppfile)
end

-- Map the functions to commands for easy usage
vim.api.nvim_create_user_command("CompileCurrentCpp", compile_current_cpp, {})
vim.api.nvim_create_user_command("SetStdNumber", function(opts)
  set_stdnumber(opts.args)
end, { nargs = 1 })

-- Create an autocommand group
vim.api.nvim_create_augroup("AutoSave", { clear = true })

-- Define the autocommand to save the current buffer on focus lost
vim.api.nvim_create_autocmd("BufLeave", {
  group = "AutoSave",
  pattern = "*",
  command = "silent! update",
})

-- local cmp = require("cmp")
-- cmp.setup({
--   sorting = {
--     comparators = {
--       -- Comparator that boosts Variables first, then Snippets
--       function(entry1, entry2)
--         local kind1 = entry1:get_kind()
--         local kind2 = entry2:get_kind()
--
--         -- Variables highest
--         if kind1 == cmp.lsp.CompletionItemKind.Variable and kind2 ~= cmp.lsp.CompletionItemKind.Variable then
--           return true
--         elseif kind2 == cmp.lsp.CompletionItemKind.Variable and kind1 ~= cmp.lsp.CompletionItemKind.Variable then
--           return false
--         end
--
--         -- Snippets second
--         if kind1 == cmp.lsp.CompletionItemKind.Snippet and kind2 ~= cmp.lsp.CompletionItemKind.Snippet then
--           return true
--         elseif kind2 == cmp.lsp.CompletionItemKind.Snippet and kind1 ~= cmp.lsp.CompletionItemKind.Snippet then
--           return false
--         end
--       end,
--       cmp.config.compare.offset,
--       cmp.config.compare.exact,
--       cmp.config.compare.score,
--       cmp.config.compare.kind,
--       cmp.config.compare.sort_text,
--       cmp.config.compare.length,
--       cmp.config.compare.order,
--     },
--   },
-- })
--
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- require("lspconfig").clangd.setup({ capabilities = capabilities })
-- vim.opt.tabstop = 4 -- Set the width of a tab character to 1
-- vim.opt.shiftwidth = 4 -- Set the number of spaces for each step of (auto)indent
-- vim.opt.expandtab = false -- Use actual tab characters instead of spaces
