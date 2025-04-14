local dap = require('dap')
require('dap.ext.vscode').load_launchjs(nil, {coreclr={'cs'}, ["nativescript"]={'typescript'},["pwa-node"]={'typescript'}, ["pwa-chrome"]={'typescript'}, ["chrome"]={'typescript'}})


dap.adapters.coreclr = {
  type = 'executable',
  command = '/usr/local/netcoredbg',
  args = {'--interpreter=vscode'}
}


dap.adapters.nativescript = {
  type = 'executable',
  command = 'node',
  args = {'--nolazy', os.getenv("HOME") .. '/src/nativescript-vscode-extension/out/debug-adapter/nativescriptDebug.js'}
}

dap.adapters.chrome = {
  type = 'executable',
  command = 'node',
  args = {os.getenv("HOME") .. "/src/vscode-chrome-debug/out/src/chromeDebug.js"}
}

require("dap-vscode-js").setup({
   adapters = { 'pwa-node', 'pwa-chrome', 'node-terminal', 'pwa-extensionHost'}, -- which adapters to register in nvim-dap
   debugger_path = os.getenv("HOME") .. "/src/vscode-js-debug", -- path to the vscode-js-debug extension
})


