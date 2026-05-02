return {
  "Wansmer/symbol-usage.nvim",
  event = "BufReadPre",
  enabled = true,
  config = function()
    require "configs.symbol"
  end,
}
