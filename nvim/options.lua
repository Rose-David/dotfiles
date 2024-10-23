vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- DAP keybinds
vim.keymap.set("n", "<Leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Debugger step into" })
vim.keymap.set("n", "<Leader>dov", "<cmd>lua require('dap').step_over()<CR>", { desc = "Debugger step over" })
vim.keymap.set("n", "<Leader>dou", "<cmd>lua require('dap').step_out()<CR>", { desc = "Debugger step out" })
vim.keymap.set("n", "<Leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Debugger continue" })
vim.keymap.set(
	"n",
	"<Leader>db",
	"<cmd>lua require('dap').toggle_breakpoint()<CR>",
	{ desc = "Debugger toggle breakpoint" }
)
vim.keymap.set(
	"n",
	"<Leader>dd",
	"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
vim.keymap.set("n", "<Leader>de", "<cmd>lua require('dap').terminate()<CR>", { desc = "Debugger reset" })
vim.keymap.set("n", "<Leader>dr", "<cmd>lua require('dap').run_last()<CR>", { desc = "Debugger run last" })
-- rustaceanvim
vim.keymap.set("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
vim.keymap.set("n", "<Leader>Cr", "<cmd>lua vim.cmd('RustLsp run')<CR>", { desc = "Cargo run" })
-- remote-sshfs
local api = require('remote-sshfs.api')
vim.keymap.set('n', "<leader>rc", api.connect, { desc = "Connect to Remote" })
vim.keymap.set('n', "<leader>rd", api.disconnect, { desc = "Disconnect from Remote" })
vim.keymap.set('n', "<leader>re", api.edit, { desc = "Remote Edit" })
-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
-- Telescope and remote-sshfs
local connections = require("remote-sshfs.connections")
-- vim.keymap.set('n', "<leader>ff", function()
-- 	if connections.is_connected then
-- 		api.find_files({})
-- 	else
-- 		builtin.find_files()
-- 	end
-- end, { desc = "Find Files" })
-- vim.keymap.set('n', "<leader>fg", function()
-- 	if connections.is_connected then
-- 		api.live_grep({})
-- 	else
-- 		builtin.live_grep()
-- 	end
-- end, { desc = "Live Grep" })
vim.keymap.set('n', "<leader>rff", api.find_files, { desc = "Remote Find Files" })
vim.keymap.set('n', "<leader>rfg", api.live_grep, { desc = "Remote Live Grep" })
-- Telescope and Project
vim.keymap.set("n", "<leader>fp", function()
	require("telescope").extensions.projects.projects({})
end, { desc = "Find Help Tags" })
-- Conform
vim.api.nvim_create_user_command("Format", function()
	require("conform").format()
end, {})
-- FTerm
vim.keymap.set({ "n", "t" }, "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>', { desc = "Toggle Terminal" })
-- Trouble
vim.keymap.set("n", "<leader>td", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Toggle Diagnostics" })
vim.keymap.set("n", "<leader>ts", "<CMD>Trouble symbols toggle<CR>", { desc = "Toggle Symbols" })
vim.keymap.set("n", "<leader>tq", "<CMD>Trouble quickfix toggle<CR>", { desc = "Toggle Quickfix" })
vim.keymap.set("n", "<leader>tl", "<CMD>Trouble lsp toggle win.position=right<CR>", { desc = "Toggle LSP info" })
-- Trouble and Todo-comments
vim.keymap.set("n", "<leader>tt", "<CMD>Trouble todo toggle<CR>", { desc = "Toggle TODOs" })
-- Todo-comments
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next TODO" })
vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous TODO" })

vim.o.clipboard = "unnamedplus"

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = "a"
