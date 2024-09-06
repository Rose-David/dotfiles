vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- you can also put keymaps in here
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

      bufmap('<Leader>e', "<cmd>RustLsp explainError<CR>")

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, {})
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

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

