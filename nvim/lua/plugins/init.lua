return {
  { "nvim-lua/plenary.nvim", commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7" }, -- Useful lua functions used by lots of plugins
  { "windwp/nvim-autopairs", commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" },
  -- Autopairs, integrates with both cmp and reesitter
  { "numToStr/Comment.nvim", commit = "97a188a98b5a3a6f9b1b850799ac078faa17ab67" },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  { "moll/vim-bbye",                       commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
  { "akinsho/toggleterm.nvim",             commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda" },
  { "lewis6991/impatient.nvim",            commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6" },
  { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" },
  { "goolord/alpha-nvim",                  commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31" },
  -- Cmp
  { "hrsh7th/nvim-cmp" },                                                              -- The completion plugin
  { "hrsh7th/cmp-buffer",                  commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" }, -- buffer completions
  { "hrsh7th/cmp-path",                    commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" }, -- path completions
  { "saadparwaiz1/cmp_luasnip",            commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }, -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  -- Snippets
  { "L3MON4D3/LuaSnip",             commit = "8f8d493e7836f2697df878ef9c128337cbf2bb84" },    --snippet engine
  { "rafamadriz/friendly-snippets", commit = "2be79d8a9b03d4175ba6b3d14b082680de1b31b1" },    -- a bunch of snippets to use
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
