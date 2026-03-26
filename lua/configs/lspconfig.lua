-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "clangd", "eslint", "pyright", "vtsls"}
local nvlsp = require "nvchad.configs.lspconfig"

for _, lsp in ipairs(servers) do
  if lsp == "eslint" then
    lspconfig.eslint.setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      root_dir = require("lspconfig.util").root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json"),
    }
  elseif lsp == "clangd" then
    lspconfig.clangd.setup {
      cmd = {"/usr/bin/clangd", "--clang-tidy", "--header-insertion=never"},
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  else
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end


-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
