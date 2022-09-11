local Job = require("plenary.job")
local tbl = require("plenary.tbl")
local config = require("tanu.config")

local M = {}

local function git(...)
  local job = Job:new({
    enable_recording = true,
    command = "git",
    args = tbl.pack(...),
  })
  return job:sync()
end

function M.get_origin()
  local result = git("remote", "get-url", config.values.default_remote)

  if not result or not result[1] then
    return nil
  end
  local origin = result[1]

  local host, repo = origin:match("%a@(.*):(.*)%.git")
  if host then
    return "https://" .. host, repo
  end
  return origin:match("(http[s]?://[%a%.]+)/(.*)%.git")
end

return M
