-- lua/plugins/navigation/telescope.lua
-- telescope.nvim: the fuzzy finder. LazyVim includes it; we extend with
-- ripgrep-powered live grep, fzf-native sorting, and extra pickers.

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        -- Native FZF sorter (C) — dramatically faster matching
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        prompt_prefix = "   ",
        selection_caret = "  ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.90,
          height = 0.85,
          preview_cutoff = 120,
        },
        -- ripgrep flags: search hidden files, respect .gitignore, smart-case
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!**/.git/*",
        },
        file_ignore_patterns = {
          "%.git/",
          "node_modules/",
          "%.venv/",
          "target/",
          "dist/",
          "%.lock",
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<C-u>"] = false, -- clear prompt instead of scrolling preview up
            ["<Esc>"] = actions.close, -- single Esc closes (no normal mode)
          },
          n = {
            ["q"] = actions.close,
          },
        },
      })
      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        find_files = {
          -- Include hidden files but exclude .git
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
        },
      })
      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      })
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
    end,
    -- stylua: ignore
    keys = {
      { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Grep (root dir)" },
      { "<leader>fw", function() require("telescope.builtin").grep_string() end, desc = "Grep Word Under Cursor" },
      { "<leader>fr", function() require("telescope.builtin").resume() end, desc = "Resume Last Picker" },
      { "<leader>f/", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Fuzzy Find in Buffer" },
      { "<leader>fk", function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
      { "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "Recent Files" },
    },
  },
}
