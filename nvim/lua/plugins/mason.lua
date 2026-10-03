local on_attach = require("user.lsp.on_attach")

return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "ashleyj/lsp_signature.nvim",
    "Issafalcon/lsp-overloads.nvim",
    "Hoffs/omnisharp-extended-lsp.nvim"
  },

  config = function()
    local servers = {
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
      "terraform-ls",
      "pylsp",
      "texlab",
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


    vim.lsp.handlers["textDocument/hover"] = function() vim.lsp.handlers.hover { border = "rounded", } end

    vim.lsp.handlers["textDocument/signatureHelp"] = function() vim.lsp.handlers.signature_help { border = "rounded", } end

    local settings = {
      ui = {
        border = "rounded",
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

      if server == "angularls" then
        opts.on_init = function(client)
          if client.root_dir == nil then
            client:stop()
          end
        end
      end

      if server == "omnisharp" then
        opts.cmd = { vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp" }

        opts.on_init = function(client)
          client.server_capabilities.hoverProvider = true
        end

        opts.handlers = {
          ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
          ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
          ["textDocument/references"] = require('omnisharp_extended').references_handler,
          ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
        }

        require 'lspconfig'.omnisharp.setup(opts)
        goto continue
      end

      if server == "terraform-ls" then
        require 'lspconfig'.terraformls.setup({})
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
