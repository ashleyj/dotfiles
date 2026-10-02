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
        path = nil,
        auto_install = true,
      },

      log = {
        use_console = true,
        use_file = true,
        level = 'info',
        log_file = vim.fn.stdpath('state') .. '/nvim-java.log',
        max_lines = 1000,
        show_location = false,
      },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )

    require('lspconfig').jdtls.setup({
      capabilities = capabilities,
    })
  end


}
