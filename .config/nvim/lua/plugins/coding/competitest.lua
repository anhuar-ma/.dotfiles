-- lua/plugins/coding/competitest.lua
-- competitest.nvim — competitive-programming testcase manager.
-- Migrated/upgraded from the previous config.
--
-- Keybinds: all under <leader>P ("competitive Programming") so they do NOT
-- shadow LazyVim's <leader>c code group (rename / code action / format / etc).
-- The which-key group label is registered at the bottom.
--
-- Improvements over the previous config:
--   * template path resolved via vim.fn.stdpath("config")/templates/main.cpp
--     instead of a hardcoded "~/.config/nvim/..." path
--   * keymaps moved off <leader>c to the dedicated <leader>P prefix

return {
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    cmd = { "CompetiTest", "Cp" },
    -- stylua: ignore
    keys = {
      { "<leader>Pr", "<cmd>CompetiTest run<cr>",                  desc = "CP: run testcases" },
      { "<leader>PR", "<cmd>CompetiTest run_no_compile<cr>",       desc = "CP: run (no recompile)" },
      { "<leader>Pu", "<cmd>CompetiTest show_ui<cr>",              desc = "CP: show UI" },
      { "<leader>Pa", "<cmd>CompetiTest add_testcase<cr>",         desc = "CP: add testcase" },
      { "<leader>Pe", "<cmd>CompetiTest edit_testcase<cr>",        desc = "CP: edit testcase" },
      { "<leader>Pd", "<cmd>CompetiTest delete_testcase<cr>",      desc = "CP: delete testcase" },
      { "<leader>Pp", "<cmd>CompetiTest receive problem<cr>",      desc = "CP: receive problem" },
      { "<leader>Pc", "<cmd>CompetiTest receive contest<cr>",      desc = "CP: receive contest" },
      { "<leader>Pt", "<cmd>CompetiTest receive testcases<cr>",    desc = "CP: receive testcases" },
      { "<leader>PP", "<cmd>CompetiTest receive persistently<cr>", desc = "CP: receive persistent" },
      { "<leader>PS", "<cmd>CompetiTest receive stop<cr>",         desc = "CP: stop receiving" },
    },
    config = function()
      local TEMPLATE = vim.fn.stdpath("config") .. "/templates/main.cpp"

      require("competitest").setup({
        compile_command = {
          c = {
            exec = "gcc",
            args = { "-O2", "-Wall", "-Wextra", "$(FNAME)", "-o", "$(FNOEXT)" },
          },
          cpp = {
            exec = "g++",
            args = {
              "-std=c++23",
              "-Wall",
              "-Wextra",
              "-Wshadow",
              "-Wconversion",
              "-Wfloat-equal",
              "-fsanitize=address,undefined",
              "-fno-omit-frame-pointer",
              "-D_GLIBCXX_DEBUG",
              "-DLOCAL",
              "-g",
              "$(FNAME)",
              "-o",
              "$(FNOEXT)",
            },
          },
          rust = { exec = "rustc", args = { "-O", "$(FNAME)" } },
          java = { exec = "javac", args = { "$(FNAME)" } },
        },

        -- Run with unlimited stack so ASan builds don't die on deep recursion.
        run_command = {
          c = { exec = "bash", args = { "-c", 'ulimit -s unlimited; "./$(FNOEXT)"' } },
          cpp = { exec = "bash", args = { "-c", 'ulimit -s unlimited; "./$(FNOEXT)"' } },
          rust = { exec = "./$(FNOEXT)" },
          java = { exec = "java", args = { "$(FNOEXT)" } },
          python = { exec = "python3", args = { "$(FNAME)" } },
        },

        compile_directory = ".",
        running_directory = ".",
        save_current_file = true,
        save_all_files = false,

        multiple_testing = -1, -- use all cores
        maximum_time = 5000, -- 10s; ASan is slow
        output_compare_method = "squish",
        view_output_diff = true,

        testcases_directory = "./tests",
        testcases_use_single_file = false,
        testcases_auto_detect_storage = true,
        testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
        testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",
        testcases_single_file_format = "$(FNOEXT).testcases",

        companion_port = 27121,
        receive_print_message = true,
        start_receiving_persistently_on_setup = false,

        template_file = { cpp = TEMPLATE },
        evaluate_template_modifiers = true,
        date_format = "%Y-%m-%d %H:%M:%S",
        received_files_extension = "cpp",

        received_problems_prompt_path = false,
        received_contests_prompt_directory = false,
        received_contests_prompt_extension = false,

        open_received_problems = true,
        open_received_contests = true,
        replace_received_testcases = false,

        floating_border = "rounded",
        floating_border_highlight = "FloatBorder",

        editor_ui = {
          popup_width = 0.6,
          popup_height = 0.7,
          show_nu = true,
          show_rnu = true,
        },

        runner_ui = {
          interface = "popup",
          selector_show_nu = false,
          selector_show_rnu = false,
          show_nu = true,
          show_rnu = false,
          viewer = {
            width = 0.75,
            height = 0.75,
            show_nu = true,
            show_rnu = false,
            open_when_compilation_fails = true,
          },
        },

        -- Popup layout optimised for diffing:
        --   row 1: testcase selector (narrow)
        --   row 2: stdin  | expected
        --   row 3: stdout | stderr
        popup_ui = {
          total_width = 0.95,
          total_height = 0.95,
          layout = {
            { 1, "tc" },
            { 5, { { 1, "si" }, { 1, "so" } } },
            { 5, { { 1, "se" }, { 1, "eo" } } },
          },
        },

        split_ui = {
          position = "right",
          relative_to_editor = true,
          total_width = 0.4,
          vertical_layout = {
            { 1, "tc" },
            { 2, { { 1, "so" }, { 1, "eo" } } },
            { 2, { { 1, "si" }, { 1, "se" } } },
          },
          total_height = 0.5,
          horizontal_layout = {
            { 2, "tc" },
            { 3, { { 1, "so" }, { 1, "eo" } } },
            { 3, { { 1, "si" }, { 1, "se" } } },
          },
        },
      })

      -- Clearer pass/fail highlight colors.
      vim.api.nvim_set_hl(0, "CompetiTestRunning", { bold = true })
      vim.api.nvim_set_hl(0, "CompetiTestDone", {})
      vim.api.nvim_set_hl(0, "CompetiTestCorrect", { fg = "#a6e3a1", bold = true })
      vim.api.nvim_set_hl(0, "CompetiTestWarning", { fg = "#f9e2af" })
      vim.api.nvim_set_hl(0, "CompetiTestWrong", { fg = "#f38ba8", bold = true })

      -- :Cp <subcmd> shortcut (e.g. :Cp run, :Cp add_testcase)
      vim.api.nvim_create_user_command("Cp", function(o)
        vim.cmd("CompetiTest " .. o.args)
      end, {
        nargs = "*",
        complete = function()
          return {
            "run",
            "run_no_compile",
            "show_ui",
            "add_testcase",
            "edit_testcase",
            "delete_testcase",
            "convert",
            "receive",
          }
        end,
      })
    end,
  },

  -- -- Register the <leader>P which-key group label.
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     spec = {
  --       { "<leader>P", group = "competitive programming", icon = "" },
  --     },
  --   },
  -- },
}
