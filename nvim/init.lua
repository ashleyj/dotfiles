local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup('plugins')
require "user.options"
require "user.keymaps"
require "user.colorscheme"
require "user.cmp"
require "user.lsp"
require "user.telescope"
require "user.autopairs"
require "user.comment"
require "user.toggleterm"
require "user.project"
require "user.impatient"
require "user.alpha"
require "user.autocommands"
require "user.dap"
require "user.lsp.angular"

-- Disable highlighting
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "NONE", fg = "NONE", underline = false })
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "NONE", fg = "NONE", underline = false })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "NONE", fg = "NONE", underline = false })
vim.api.nvim_set_hl(0, "SnippetTabstop", { bg = "NONE", fg = "NONE", bold = false })
