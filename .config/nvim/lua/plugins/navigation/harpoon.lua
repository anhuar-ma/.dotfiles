-- lua/plugins/navigation/harpoon.lua
-- harpoon (v2): pin a handful of files and teleport between them instantly.
-- Ideal for the 4-5 files you live in during a feature; faster than fuzzy find.

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          key = function()
            -- Scope marks per git root / cwd so each project keeps its own list
            return vim.loop.cwd()
          end,
        },
      })
    end,
    -- stylua: ignore
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
      { "<leader>hh", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon Quick Menu" },
      { "<leader>hr", function() require("harpoon"):list():remove() end, desc = "Harpoon Remove File" },
      { "<leader>hc", function() require("harpoon"):list():clear() end, desc = "Harpoon Clear All" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to File 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon to File 5" },
      { "[h", function() require("harpoon"):list():prev() end, desc = "Harpoon Prev" },
      { "]h", function() require("harpoon"):list():next() end, desc = "Harpoon Next" },
    },
  },
}
