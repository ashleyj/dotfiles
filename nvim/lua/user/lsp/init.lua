local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.mason"
require("user.lsp.handlers").setup()
local on_attach = function(client, bufnr)
    if client.server_capabilities then
        client.server_capabilities.documentHighlightProvider = false
    end
end



require'lspconfig'.dartls.setup{
  on_attach = on_attach
}


--local cfg = {}  -- add your config here
--require "lsp_signature".setup(cfg)

