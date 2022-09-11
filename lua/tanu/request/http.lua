local curl = require("plenary.curl")
local config = require("tanu.config")

local M = {}

local function parse_url(host)
  return host .. "/api/graphql"
end

function M.graphql(host, query, variables)
  local url = parse_url(host)
  local host_config = config.values.hosts[host]
  if not host or not host_config then
    return nil
  end
  local opts = {
    headers = {
      content_type = "application/json",
      authorization = "Bearer " .. host_config.token,
    },
    raw_body = vim.fn.json_encode({
      query = query,
      variables = variables,
    }),
  }
  local resp = curl.post(url, opts)

  local body = resp.status == 200 and vim.fn.json_decode(resp.body) or nil
  return resp.status, body
end

return M
