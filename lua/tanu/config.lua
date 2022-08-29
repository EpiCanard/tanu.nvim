local M = {}

local default = {

}

M.config = default

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default, user_config or {})
end

return M
