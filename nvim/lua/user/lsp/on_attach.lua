-- Shared on_attach function for all LSP servers
return function(client, bufnr)
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
