-- dapui setup
local dap, dapui = require("dap"), require("dapui")

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


-- keybinds setup
local on_attach = function(_, bufnr)
	local map = vim.keymap.set

	map('n', "<Leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Debugger step into", buffer = bufnr }) 
	map('n', "<Leader>dov", "<cmd>lua require('dap').step_over()<CR>", { desc = "Debugger step over", buffer = bufnr  }) 
	map('n', "<Leader>dou", "<cmd>lua require('dap').step_out()<CR>", { desc = "Debugger step out", buffer = bufnr  })
	map('n', "<Leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Debugger continue", buffer = bufnr  })
	map('n', "<Leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint", buffer = bufnr  })
	map('n', "<Leader>dd", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { desc = "Debugger set conditional breakpoint", buffer = bufnr  })
	map('n', "<Leader>de", "<cmd>lua require('dap').terminate()<CR>", { desc = "Debugger reset", buffer = bufnr  })
	map('n', "<Leader>dr", "<cmd>lua require('dap').run_last()<CR>", { desc = "Debugger run last", buffer = bufnr  })
	-- rustaceanvim
	map('n', "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables", buffer = bufnr  })
end
