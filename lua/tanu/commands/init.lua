local http = require("tanu.request.http")
local git = require("tanu.git")
local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Tanu", function(opts)
    require("tanu.commands").tanu(unpack(opts.fargs))
  end, { nargs = "*" })

  M.commands = {
    mr = function()
      local origin, repo = git.get_origin()
      if origin then
        local status, body = http.graphql(origin, "query {currentUser {name}}")
        print(origin)
        print(repo)
        print(status)
        print(vim.inspect(body))
      end
    end,
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
