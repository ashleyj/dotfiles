return {
  "Mofiqul/dracula.nvim",
  config = function()
    configs = require('dracula')
    configs.setup {
      overrides = {
        ['@lsp.type.class'] = { },
        ['@lsp.type.enum'] = { },
        ['@lsp.type.decorator'] = { },
        ['@lsp.type.enumMember'] = { },
        ['@lsp.type.function'] = { },
        ['@lsp.type.interface'] = { },
        ['@lsp.type.macro'] = { },
        ['@lsp.type.method'] = { },
        ['@lsp.type.namespace'] = { },
        ['@lsp.type.parameter'] = { },
        ['@lsp.type.property'] = { },
        ['@lsp.type.struct'] = { },
        ['@lsp.type.type'] = { },
        ['@lsp.type.variable'] = { },
        ['@lsp.type.builtin'] = { },
        ['@punctuation.bracket'] = { },
        ['@type'] = { },
        ['@keyword.function'] = { },
        Keyword = {},
        Keywords = {},
        Identifier = {},
        Type = { fg = '#ff79c6' },
        TypeDef = {},
        CursorLine = { bg = '#000000' },
        TabLineSel = { bg = '#69FF94' },
        Pmenu = { bg = '#000000', fg = '#808080'  },
        PmenuSel = { bg = '#000000', fg = '#808080'},
      }
    }
  end
}
