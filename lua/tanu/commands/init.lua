local http = require("tanu.request.http")
local config = require("tanu.config")
local git = require("tanu.git")
local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Tanu", function(opts)
      require("tanu.commands").tanu(unpack(opts.fargs))
    end,
    {nargs="*"}
  )

  M.commands = {
    mr = function()
      local status, body = http.graphql(config.config.hosts.default, "query {currentUser {name}}")
      print(status)
      print(vim.inspect(body))
      print(git.get_origin_url())
    end
  }
end

function M.tanu(subcmd)
  subcmd = subcmd or "mr"

  if not M.commands[subcmd] then
    print("Unknown command")
  else
    M.commands[subcmd]()
  end

end

return M
