-- Shared on_attach function for all LSP servers
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  if client.name == "omnisharp" then
    keymap(bufnr, "n", "gd", "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>", opts)
    keymap(bufnr, "n", "gr", "<cmd>lua require('omnisharp_extended').lsp_references()<cr>", opts)
    keymap(bufnr, "n", "gi", "<cmd>lua require('omnisharp_extended').lsp_implementations()<cr>", opts)
    keymap(bufnr, "n", '<leader>D', "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>", opts)
  end

  client.server_capabilities.documentHighlightProvider = false
  client.capabilities.textDocument.completion.completionItem.snippetSupport = true

  if client.server_capabilities.signatureHelpProvider then
    require('lsp-overloads').setup(client, {
      ui = {
        border = "single",
        height = nil,
        width = nil,
        wrap = true,
        wrap_at = nil,
        max_width = nil,
        max_height = nil,
        close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
        focusable = true,
        focus = false,
        offset_x = 0,
        offset_y = 0,
        floating_window_above_cur_line = false,
        silent = true,
        highlight = {
          italic = true,
          bold = true,
          fg = "#ffffff",
        }
      },
      keymaps = {
        next_signature = "<C-j>",
        previous_signature = "<C-k>",
        next_parameter = "<C-l>",
        previous_parameter = "<C-h>",
        close_signature = "<c-q>"
      },
      display_automatically = true
    })
  end
end

return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "ashleyj/lsp_signature.nvim",
    "Issafalcon/lsp-overloads.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim",
    {
      "mfussenegger/nvim-jdtls",
      ft = "java",
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "java",
          callback = function()
            local jdtls = require('jdtls')

            -- Find the root directory, preferring parent pom.xml or .git
            local root_dir = vim.fs.root(0, {'.git', 'mvnw', 'gradlew'})
            if not root_dir then
              root_dir = vim.fs.root(0, {'pom.xml'})
            end

            local project_name = vim.fn.fnamemodify(root_dir or vim.fn.getcwd(), ':p:h:t')
            local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. project_name

            -- Create capabilities
            local cmp = require("cmp_nvim_lsp")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities = cmp.default_capabilities(capabilities)

            local config = {
              cmd = {"/home/ash/src/jdtls/bin/jdtls", "-data", workspace_dir},
              root_dir = root_dir,
              settings = {
                java = {}
              },
              init_options = {
                bundles = {}
              },
              on_attach = on_attach,
              capabilities = capabilities
            }

            jdtls.start_or_attach(config)
          end
        })
      end
    },
  },

  config = function()
    local servers = {
      "jdtls",
      "lua_ls",
      "cssls",
      "html",
      "ts_ls",
      "pyright",
      "bashls",
      "jsonls",
      "yamlls",
      "omnisharp",
      "intelephense",
      "angularls",
      "terraformls",
      "pylsp"
    }


    -- Suppress lspconfig warnings
    local notify = vim.notify
    vim.notify = function(msg, ...)
      if type(msg) == "string" and msg:match("lspconfig") then
        return
      end
      notify(msg, ...)
    end


    vim.diagnostic.config({
      virtual_text = true,
      underline = {
        -- severity = { in = vim.diagnostic.severity.WARN },
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      },
    })


    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    local settings = {
      ui = {
        border = "none",
        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 4,
    }

    require("mason").setup(settings)

    local opts = {}
    local cmp = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities = cmp.default_capabilities(capabilities)

    for _, server in pairs(servers) do
      opts = {
        on_attach = on_attach,
        capabilities = capabilities
      }

      server = vim.split(server, "@")[1]

      if server == "omnisharp" then
        opts.cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp" }


        -- Hack around omnisharp not respecting the lspconfig setup
        opts.handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
          ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
          ["textDocument/references"] = require('omnisharp_extended').references_handler,
          ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
        }

        require 'lspconfig'.omnisharp.setup(opts)
        goto continue
      end

      if server == "jdtls" then
        -- Skip jdtls in the main loop, it's handled by autocmd below
        goto continue
      end

      local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
      if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
      end

      if server == "angularls" then
        local mason_packages = vim.fn.stdpath("data") .. "/mason/packages"

        opts.cmd = {
          "node",
          mason_packages .. "/angular-language-server/node_modules/@angular/language-server/index.js",
          "--stdio",
          "--tsProbeLocations", "/opt/homebrew/lib/node_modules",
          "--ngProbeLocations", mason_packages .. "/angular-language-server/node_modules",
        }

        opts.cmd_env = {
          NODE_PATH = "/opt/homebrew/lib/node_modules"
        }
      end

      vim.lsp.config(server, opts)
      vim.lsp.enable(server)
      ::continue::
    end
    cfg = {
      debug = true, -- set to true to enable debug logging
      --log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
      -- default is  ~/.cache/nvim/lsp_signature.log
      verbose = false, -- show debug line number

      bind = true,     -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 10,  -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      max_height = 12,                        -- max height of signature floating_window
      max_width = 80,                         -- max_width of signature floating_window, line will be wrapped if exceed max_width
      -- the value need >= 40
      wrap = true,                            -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
      floating_window = false,                -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap

      floating_window_off_x = 1,   -- adjust float windows x position.
      -- can be either a number or function
      floating_window_off_y = -10, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
      -- can be either number or function, see examples

      close_timeout = 4000, -- close floating window after ms when laster parameter is entered
      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
      hint_scheme = "String",
      hint_inline = function() return false end, -- should the hint be inline(nvim 0.10 only)?  default false
      -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
      -- return 'right_align' to display hint right aligned in the current line
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      handler_opts = {
        border = "rounded"                          -- double, rounded, single, shadow, none, or a table of borders
      },

      always_trigger = false,                   -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil,                   -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {},                 -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200,                             -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = '',                             -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = nil,                       -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36,                        -- if you using shadow as border use this set the opacity
      shadow_guibg = 'Black',                   -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200,                     -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil,                         -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
      toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
      -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
      -- may not popup when typing depends on floating_window setting

      select_signature_key = '<C-n>', -- cycle to next signature, e.g. '<M-n>' function overloading
      move_cursor_key = nil,          -- imap, use nvim_set_current_win to move cursor between current win and floating
    }

    -- recommended:
    require 'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

    -- You can also do this inside lsp on_attach
    -- note: on_attach deprecated
    require 'lsp_signature'.on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
  end

}
