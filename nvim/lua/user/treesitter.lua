local treesitter = require "nvim-treesitter"
local configs = require "nvim-treesitter.configs"

  configs.setup {
    ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python", "c_sharp", "typescript", "terraform" },
    ignore_install = { "" },                                                       -- List of parsers to ignore installing
    sync_install = true,                                                          -- install languages synchronously (only applied to `ensure_installed`)
    auto_install = false,

    highlight = {
      enable = true,       -- false will disable the whole extension
      disable = { "css" }, -- list of language that will be disabled
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "css" } },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }

