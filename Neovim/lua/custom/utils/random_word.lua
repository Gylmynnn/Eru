--- @type function
local function random_str(len)
  local chars = {}
  for c in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"):gmatch "." do
    table.insert(chars, c)
  end

  local result = {}
  for i = 1, len do
    result[i] = chars[vim.fn.rand() % #chars + 1]
  end
  return string.format('"%s"', table.concat(result))
end

---@type function
local function insert_random_str()
  local s = random_str(64)
  vim.api.nvim_put({ s }, "c", true, true)
end

return insert_random_str
