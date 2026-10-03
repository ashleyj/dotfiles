return {
  "nvim-java/nvim-java",
  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require('java').setup({

      lombok = {
        enable = true,
        version = '1.18.48',
        path = nil,
        auto_install = true,
      },
      jdtls = {
        version = '1.54.0',
        enable = true,
        path = nil,
        auto_install = true,
      },
      spring_boot_tools = {
        auto_install = true,
        enable = true,
        version = '1.55.1'
      },

    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    -- merges over the config nvim-java already registered in setup() above
    vim.lsp.config('jdtls', {
      capabilities = capabilities,
      on_attach = require('user.lsp.on_attach'),
    })
    vim.lsp.enable('jdtls')
  end


}
