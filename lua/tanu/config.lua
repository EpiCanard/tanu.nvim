local M = {}

local default = {
  hosts = {
    default = {
      url = "https://gitlab.com",
      token = nil,
    },
  },
}

M.config = default

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default, user_config or {})
end

return M
