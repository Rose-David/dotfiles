-- dapui setup
local dap = require("dap")
local dapui = require("dapui")

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-dap', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- keybinds setup
local map = vim.keymap.set

local on_attach = function(_, bufnr)
	map('n', "<Leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Debugger step into", buffer = bufnr }) 
	map('n', "<Leader>dov", "<cmd>lua require('dap').step_over()<CR>", { desc = "Debugger step over", buffer = bufnr }) 
	map('n', "<Leader>dou", "<cmd>lua require('dap').step_out()<CR>", { desc = "Debugger step out", buffer = bufnr })
	map('n', "<Leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Debugger continue", buffer = bufnr })
	map('n', "<Leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint", buffer = bufnr })
	map('n', "<Leader>dd", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debugger set conditional breakpoint", buffer = bufnr })
	map('n', "<Leader>de", "<cmd>lua require('dap').terminate()<CR>", { desc = "Debugger reset", buffer = bufnr })
	map('n', "<Leader>dr", "<cmd>lua require('dap').run_last()<CR>", { desc = "Debugger run last", buffer = bufnr })
	-- rustaceanvim
	map('n', "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables", buffer = bufnr })
end

