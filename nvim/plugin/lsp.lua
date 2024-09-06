local on_attach = function(_, bufnr)

  local bufmap = function(keys, func)
    vim.keymap.set('n', keys, func, { buffer = bufnr })
  end

  bufmap('<leader>r', vim.lsp.buf.rename)
  bufmap('<leader>a', vim.lsp.buf.code_action)

  bufmap('gd', vim.lsp.buf.definition)
  bufmap('gD', vim.lsp.buf.declaration)
  bufmap('gI', vim.lsp.buf.implementation)
  bufmap('<leader>D', vim.lsp.buf.type_definition)

  bufmap('gr', require('telescope.builtin').lsp_references)
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

  bufmap('K', vim.lsp.buf.hover)

-- keybinds setup
--[[  
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
--]]
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()
require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
	root_dir = function()
        return vim.loop.cwd()
    end,
	cmd = { "lua-lsp" },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    }
}

--[[
require('lspconfig').rnix.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
--]]

--[[
require('lspconfig').rust_analyzer.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	    root_dir = function()
	    return vim.loop.cwd()
	end,
	    cmd = { "rust-analyzer" },
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = false;
			}
		}
	}
}
--]]

require('lspconfig').clangd.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	    root_dir = function()
	    return vim.loop.cwd()
	end,
	    cmd = { "clangd" },
	settings = {
		['clangd'] = {
			diagnostics = {
				enable = false;
			}
		}
	}
}
