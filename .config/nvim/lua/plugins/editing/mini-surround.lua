-- lua/plugins/editing/mini-surround.lua
-- mini.surround: add/delete/replace surrounding pairs (quotes, brackets, tags)
-- LazyVim ships mini.surround in its editor extra; here we make the mappings
-- explicit and ergonomic so they don't collide with other plugins.

return {
  {
    "nvim-mini/mini.surround",
    keys = function(_, keys)
      -- Populate the keys so lazy.nvim lazy-loads on first use.
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.find, desc = "Find Right Surrounding" },
        { opts.mappings.find_left, desc = "Find Left Surrounding" },
        { opts.mappings.highlight, desc = "Highlight Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      -- gs* prefix keeps surround commands out of the way of `s`/`cs`/`ds`
      -- defaults that some users rely on for substitute.
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
      -- How many lines to search for surroundings
      n_lines = 50,
      -- Whether to respect selection type for visual mode add
      respect_selection_type = true,
      -- Search method: cover, cover_or_next, cover_or_prev, cover_or_nearest
      search_method = "cover_or_next",
    },
  },
}
