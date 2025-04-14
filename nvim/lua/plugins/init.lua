return {
  { "nvim-lua/plenary.nvim"}, -- Useful lua functions used by lots of plugins
  { "windwp/nvim-autopairs"},
  -- Autopairs, integrates with both cmp and reesitter
  { "numToStr/Comment.nvim"},
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  { "moll/vim-bbye"},
  { "akinsho/toggleterm.nvim"},
  { "lewis6991/impatient.nvim"},
  { "lukas-reineke/indent-blankline.nvim"},
  { "goolord/alpha-nvim",},
  -- Cmp
  { "hrsh7th/nvim-cmp" },                                                              -- The completion plugin
  { "hrsh7th/cmp-buffer"}, -- buffer completions
  { "hrsh7th/cmp-path"}, -- path completions
  { "saadparwaiz1/cmp_luasnip"}, -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  -- Snippets
  { "L3MON4D3/LuaSnip"},    --snippet engine
  { "rafamadriz/friendly-snippets"},    -- a bunch of snippets to use
  -- LSP
  "neovim/nvim-lspconfig",                                                                    -- enable LSP
  "williamboman/mason.nvim",                                                                  -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim",
  -- Telescope
  { "nvim-telescope/telescope.nvim",   tag = "0.1.4" },
  --{"lewis6991/gitsigns.nvim", commit = "2c6f96dda47e55fa07052ce2e2141e8367cbaaf2" },
  "mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",
  { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  { "folke/neodev.nvim",         opts = {} },
  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "microsoft/vscode-js-debug",
    opt = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  "stevearc/conform.nvim",
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {}
    end
  },
  "mbbill/undotree",
  "theHamsta/nvim-dap-virtual-text",
  { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" }
      }
    end
  },
  {
    "microsoft/vscode-js-debug",
    opt = true,
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
  },
  "nvim-lua/plenary.nvim",
  { "OmniSharp/omnisharp-vim",   commit = "cdbf65bc4385d7026428d2f392b40a317725cc9c" },
  "puremourning/vimspector",
  "ray-x/lsp_signature.nvim",
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-ui",
  "mhartington/formatter.nvim",
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {}
    end
  }
}
