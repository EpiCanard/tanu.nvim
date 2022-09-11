local levels = {
  error = "ErrorMsg",
  warn = "WarningMsg",
  info = "None",
  debug = "Comment",
}

local function format_message(...)
  local msg = ""
  for _, v in ipairs({ ... }) do
    if type(v) == "table" then
      msg = msg .. vim.inspect(v)
    else
      msg = msg .. tostring(v)
    end
  end
  return msg
end

local function log(level)
  return function(...)
    local msg = format_message(...)
    vim.api.nvim_echo({
      { string.format("[tanu][%s] %s", level:upper(), msg), levels[level] },
    }, false, {})
  end
end

local M = {}

for k, _ in pairs(levels) do
  M[k] = log(k)
end

return M
