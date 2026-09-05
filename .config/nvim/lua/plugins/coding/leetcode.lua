-- lua/plugins/coding/leetcode.lua
-- leetcode.nvim: solve LeetCode problems inside Neovim. Migrated from the
-- previous config.

return {
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      editor = {
        reset_previous_code = false,
        fold_imports = true,
      },
      storage = {
        home = vim.fn.expand("~/Codes/Leetcode/"),
      },
      -- Template injection is handled in the config function below via the
      -- "@leet start" marker, not by leetcode.nvim's own injector.
    },
    config = function(_, opts)
      require("leetcode").setup(opts)

      local TEMPLATE_PATH = vim.fn.stdpath("config") .. "/templates/leetcode.cpp"
      local SENTINEL = "// __LC_TEMPLATE_INJECTED__"

      local function inject_template(bufnr)
        if vim.bo[bufnr].filetype ~= "cpp" then
          return
        end
        if vim.fn.filereadable(TEMPLATE_PATH) == 0 then
          return
        end

        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        -- Locate the "@leet start" marker line.
        local start_idx
        for i, line in ipairs(lines) do
          if line:match("@leet%s*c?o?d?e?%s*start") then
            start_idx = i -- 1-indexed
            break
          end
        end
        if not start_idx then
          return
        end

        -- Already injected?
        if lines[start_idx + 1] == SENTINEL then
          return
        end

        local template = { SENTINEL }
        for line in io.lines(TEMPLATE_PATH) do
          table.insert(template, line)
        end

        vim.api.nvim_buf_set_lines(bufnr, start_idx, start_idx, false, template)
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("silent! write")
        end)
      end

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = vim.fn.expand("~/Codes/Leetcode/") .. "*.cpp",
        callback = function(args)
          inject_template(args.buf)
        end,
      })
    end,
  },
}
