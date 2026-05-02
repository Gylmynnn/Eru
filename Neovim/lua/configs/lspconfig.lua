--- @type table
local servers = { "prismals", "jsonls", "pyright", "hyprls", "html", "cssls", "svelte", "ts_ls", "lua_ls", "gopls" }

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable(servers)
