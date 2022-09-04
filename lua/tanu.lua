local config = require("tanu.config")
local commands = require("tanu.commands")

local M = {}

function M.setup(user_config)
  config.setup(user_config)
  commands.setup()
end

return M
