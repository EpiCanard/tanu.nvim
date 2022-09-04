local curl = require("plenary.curl")

local M = {}

local function parse_url(host)
  return host.url .. "/api/graphql"
end

function M.graphql(host, query, variables)
  local url = parse_url(host)
  local opts = {
    headers = {
      content_type = "application/json",
      authorization = "Bearer " .. host.token
    },
    raw_body = vim.fn.json_encode({
      query = query,
      variables = variables
    })
  }
  local resp = curl.post(url, opts)

  local body = resp.status == 200 and vim.fn.json_decode(resp.body) or nil
  return resp.status, body
end

return M
