
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = 'a'
