local on_attach = function(_, bufnr)
	local bufmap = function(keys, func, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set("n", keys, func, opts)
	end

	bufmap("<leader>r", vim.lsp.buf.rename, { desc = "Rename Symbol" })
	bufmap("<leader>a", vim.lsp.buf.code_action, { desc = "Code Action" })

	bufmap("gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
	bufmap("gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
	bufmap("gI", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
	bufmap("<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })

	bufmap("gr", require("telescope.builtin").lsp_references, { desc = "Search References" })
	bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols, { desc = "Search Document Symbols" })
	bufmap(
		"<leader>S",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ desc = "Search Dynamic Workspace Symbols" }
	)

	bufmap("K", vim.lsp.buf.hover)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()
require("lspconfig").lua_ls.setup({
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
	},
})

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

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "clangd" },
	settings = {
		["clangd"] = {
			diagnostics = {
				enable = false,
			},
		},
	},
})
