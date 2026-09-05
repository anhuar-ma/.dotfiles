return {
  -- snacks.nvim: include hidden files in the picker, and add a custom
  -- `explorer_copy` action (copy selected entries, or prompt for a new name).
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        sources = {
          explorer = {
            actions = {
              explorer_copy = function(picker, item)
                if not item then
                  return
                end

                local paths = vim.tbl_map(Snacks.picker.util.path, picker:selected())

                -- Multi-select: copy all selected entries into the current dir.
                if #paths > 0 then
                  local dir = picker:dir()
                  Snacks.picker.util.copy(paths, dir)
                  picker.list:set_selected()
                  require("snacks.explorer.tree"):refresh(dir)
                  require("snacks.explorer.tree"):open(dir)
                  require("snacks.explorer.actions").update(picker, { target = dir })
                  return
                end

                -- Single item: prompt for a destination name.
                Snacks.input({
                  prompt = "Copy to",
                  default = vim.fn.fnamemodify(item.file, ":t"),
                }, function(value)
                  if not value or value:find("^%s*$") then
                    return
                  end

                  local to = vim.fs.normalize(vim.fs.dirname(item.file) .. "/" .. value)
                  if vim.uv.fs_stat(to) then
                    Snacks.notify.warn("File already exists:\n- `" .. to .. "`")
                    return
                  end

                  Snacks.picker.util.copy_path(item.file, to)
                  require("snacks.explorer.tree"):refresh(vim.fs.dirname(to))
                  require("snacks.explorer.actions").update(picker, { target = to })
                end)
              end,
            },
          },
        },
      },
    },
  },
}
