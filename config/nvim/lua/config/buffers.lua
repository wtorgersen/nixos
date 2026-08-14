local M = {}

function M.new()
  vim.cmd("enew")
end

function M.close()
  if not vim.bo.modified then
    vim.cmd("bdelete")
    return
  end

  local choice = vim.fn.confirm(
    "Buffer has unsaved changes. Close anyway?",
    "&Yes\n&No",
    2
  )

  if choice == 1 then
    vim.cmd("bdelete!")
  end
end

function M.save_and_close()
  vim.cmd.write()
  vim.cmd.bdelete()
end

return M
