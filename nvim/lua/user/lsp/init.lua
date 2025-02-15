local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
require'lspconfig'.dartls.setup{}


--local cfg = {}  -- add your config here
--require "lsp_signature".setup(cfg)

