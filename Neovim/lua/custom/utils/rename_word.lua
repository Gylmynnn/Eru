--- @type function
local function replace_word()
  local word = vim.fn.expand "<cword>"

  vim.ui.input({
    prompt = "Replace '" .. word .. "' with: ",
    default = word,
  }, function(input)
    if input and input ~= "" then
      vim.cmd(string.format("%%s/\\<%s\\>/%s/gI", word, input))
    end
  end)
end

return replace_word
