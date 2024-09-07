local on_attach = function(_, bufnr)

  local bufmap = function(keys, func, opts)
    vim.keymap.set('n', keys, func, opts)
  end

  bufmap('<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" } )
  bufmap('<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

  bufmap('gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
  bufmap('gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to Declaration" })
  bufmap('gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to Implementation" } )
  bufmap('<leader>D', vim.lsp.buf.type_definition { buffer = bufnr, desc = "Type Definition" } )

  bufmap('gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = "Search References" } )
  bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols { buffer = bufnr, desc = "Search Document Symbols" })
  bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = "Search Dynamic Workspace Symbols" })

  bufmap('K', vim.lsp.buf.hover)

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
