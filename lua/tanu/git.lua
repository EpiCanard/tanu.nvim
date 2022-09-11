local Job = require("plenary.job")
local tbl = require("plenary.tbl")

local M = {}

local function git(...)
  local job = Job:new({
    enable_recording = true,
    command = "git",
    args = tbl.pack(...),
  })
  return job:sync()
end

function M.get_origin_url()
  local result = git("remote", "get-url", "origin")

  if not result or not result[1] then
    return nil
  end
  local origin = result[1]

  local host = origin:match("%a@(.*):")
  if host then
    return "https://" .. host
  end
  return origin:match("(http[s]?://[%a%.]+)/")
end

return M
