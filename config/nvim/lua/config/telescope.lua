local M = {}

function M.find_vertical()
  require("telescope.builtin").find_files({
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local function open_vertical()
        local entry = action_state.get_selected_entry()

        actions.close(prompt_bufnr)

        vim.cmd("vsplit " .. vim.fn.fnameescape(entry.path))
      end

      map("i", "<CR>", open_vertical)
      map("n", "<CR>", open_vertical)

      return true
    end,
  })
end

return M
