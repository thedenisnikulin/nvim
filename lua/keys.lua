-- space maps
vim.api.nvim_set_keymap("n", "<space>f", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>b", ":Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>d", ":Telescope diagnostics<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>s", ":Telescope lsp_document_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<space>S", ":Telescope lsp_workspace_symbols<CR>", { noremap = true })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]ename' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = '[C]ode Action' })
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })

-- goto maps
vim.keymap.set('n', 'gh', "^", { buffer = bufnr, desc = 'Goto line start' })
vim.keymap.set('n', 'gl', "$", { buffer = bufnr, desc = 'Goto line end' })
vim.keymap.set('n', 'gn', ":bnext<CR>", { buffer = bufnr, desc = 'Goto buffer [n]ext' })
vim.keymap.set('n', 'gp', ":bprevious<CR>", { buffer = bufnr, desc = 'Goto buffer [p]revious' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto [d]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto [D]eclaration'} )
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'Goto [r]eferences' })
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, { buffer = bufnr, desc = 'Goto [i]mplementation' })
vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions, { buffer = bufnr, desc = 'Goto [t]ype Definition' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

