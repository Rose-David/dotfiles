
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- DAP keybinds
vim.keymap.set('n', "<Leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Debugger step into" }) 
vim.keymap.set('n', "<Leader>dov", "<cmd>lua require('dap').step_over()<CR>", { desc = "Debugger step over" }) 
vim.keymap.set('n', "<Leader>dou", "<cmd>lua require('dap').step_out()<CR>", { desc = "Debugger step out" })
vim.keymap.set('n', "<Leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Debugger continue" })
vim.keymap.set('n', "<Leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
vim.keymap.set('n', "<Leader>dd", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debugger set conditional breakpoint" })
vim.keymap.set('n', "<Leader>de", "<cmd>lua require('dap').terminate()<CR>", { desc = "Debugger reset" })
vim.keymap.set('n', "<Leader>dr", "<cmd>lua require('dap').run_last()<CR>", { desc = "Debugger run last" })
-- rustaceanvim
vim.keymap.set('n', "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
vim.keymap.set('n', "<Leader>cr", "<cmd>lua vim.cmd('RustLsp run')<CR>", { desc = "Cargo run" })
-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set('n', "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Find Help Tags" })

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'
