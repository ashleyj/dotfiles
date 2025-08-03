local opts = { noremap = true, silent = true }
local no_remap = { noremap = false, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


keymap("n", "<leader>f", "<Cmd>Telescope git_files<CR>", term_opts)

keymap("n", "<C-w>f", "<Cmd>Neotree toggle position=left<CR>", opts)
keymap("n", "<C-w>L", "<Cmd>Neotree position=float<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-n>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<C-l>", ":BufferLineCyclePrev<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)


keymap("v", "<leader>y", '"+y', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Random shortcuts to make life easier --
keymap("n", "<C-s>", "<Cmd> Telescope live_grep<CR>", opts)

-- CoPilot --
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-p>", 'copilot#Accept("<CR>")', { silent = true, expr = true })


-- Override buffer delete --
keymap('n', 'bd', "<Cmd>BufferClose<CR>", opts)

 -- DAP--
keymap("n", "<leader>dc", "<Cmd>lua require'dap'.continue()<CR>",opts)
keymap("n", "<leader>dl", "<Cmd>lua require'dap'.run_last()<CR>",opts)
keymap("n", "<leader>db", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>",opts)
keymap("n", "<leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>",opts)
keymap("n", "<leader>ds", "<Cmd>lua require'dap'.step_over()<CR>",opts)
keymap("n", "<leader>di", "<Cmd>lua require'dap'.step_into()<CR>",opts)
keymap("n", "<leader>do", "<Cmd>lua require'dap'.step_out()<CR>",opts)

-- Ranfix fixes and opinionated behaviour --
keymap('n', '<ESC>', ':noh<CR><ESC>', no_remap)


--vim.api.nvim_create_autocmd('LspAttach', {
  --callback = function(args)
    --vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
  --end,
--})
