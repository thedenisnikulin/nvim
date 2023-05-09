local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "mfussenegger/nvim-dap" },
	{ "nvim-telescope/telescope-dap.nvim" },
	{ 'mg979/vim-visual-multi',                 branch = 'master' },
	{ "numToStr/Comment.nvim",                  opts = {} },
	{ "folke/which-key.nvim",                   opts = {} },
	{ "stevearc/dressing.nvim",                 event = "VeryLazy" },
	{ "xiyaowong/telescope-emoji.nvim" },
	{ "RRethy/vim-illuminate" },
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-surround" },
	{ 'michaelb/sniprun',                       build = 'bash ./install.sh' },
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup {}
		end
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require('neoscroll').setup()
		end
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", },
		config = function()
			require("noice").setup({
				cmdline = {
					format = {
						cmdline = { icon = ">" },
						search_down = { icon = "search [v]" },
						search_up = { icon = "search [^]" },
						filter = { icon = "filter" },
						lua = { icon = "lua" },
						help = { icon = "help" },
					}
				}
			})
		end
	},
	{
		"ggandor/flit.nvim",
		config = function()
			require('flit').setup {}
		end
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require('leap').add_default_mappings()
		end
	},
	{
		'echasnovski/mini.pairs',
		version = false,
		config = function()
			require('mini.pairs').setup()
		end
	},
	{
		'echasnovski/mini.indentscope',
		version = false,
		config = function()
			require('mini.indentscope').setup()
		end
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup {}
		end
	},
	{
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup {
				highlight = {
					pattern = [[.*<(KEYWORDS)\s* ]]
				},
				search = {
					pattern = [[\b(KEYWORDS)\b]],
				}
			}
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = 'top',
					},
					mappings = {
						i = {
							["<esc>"] = require("telescope.actions").close,
						},
					},
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("emoji")
			telescope.load_extension('dap')
		end
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim",          config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim",                opts = {} },
			{ "folke/neodev.nvim" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer" },
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "»",
			show_trailing_blankline_indent = false,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
	{
		'folke/tokyonight.nvim',
		config = function()
			require('tokyonight').setup({
				style = "night",
				on_colors = function(colors)
					colors.bg = "#08080b"
				end,
				on_highlights = function(highlights, colors)
					highlights.DiagnosticUnderlineError = {
						undercurl = false
					}
					highlights.DiagnosticUnderlineHint = {
						undercurl = false
					}
					highlights.DiagnosticUnderlineInfo = {
						undercurl = false
					}
					highlights.DiagnosticUnderlineWarn = {
						undercurl = false
					}
				end
			})
			vim.cmd [[colorscheme tokyonight]]
		end
	},
})

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set tab size
vim.opt.tabstop = 4

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable relative numbers
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

require("nvim-treesitter.configs").setup({
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { "c", "cpp", "go", "lua", "python", "rust", "tsx", "typescript", "vimdoc", "vim" },

	-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
	auto_install = false,

	highlight = { enable = true },
	indent = { enable = true, disable = { "python" } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_incremental = "<c-space>",
			scope_incremental = "<c-s>",
			node_decremental = "<M-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
		},
		swap = {
			enable = true,
		},
	},
})

local on_attach = function(_, bufnr)
	vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
end

local servers = {
	gopls = {},
	rust_analyzer = {},

	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			handlers = {
				['textDocument/hover'] = vim.lsp.with(
					vim.lsp.handlers.hover,
					{ border = 'rounded' }
				)

			}
		})
	end,
})

local cmp = require("cmp")
local luasnip = require("luasnip")

local unlinkgrp = vim.api.nvim_create_augroup(
	'UnlinkSnippetOnModeChange',
	{ clear = true }
)

vim.api.nvim_create_autocmd('ModeChanged', {
	group = unlinkgrp,
	pattern = { 's:n', 'i:*' },
	desc = 'Forget the current snippet when leaving the insert mode',
	callback = function(evt)
		if
			luasnip.session
			and luasnip.session.current_nodes[evt.buf]
			and not luasnip.session.jump_active
		then
			luasnip.unlink_current()
		end
	end,
})

luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	}
})

-- space maps
vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope file_browser<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>D", ":Telescope diagnostics<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>S", ":Telescope lsp_workspace_symbols<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>l", ":Telescope live_grep<CR>", { noremap = true })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]ename' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code [A]ction' })
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Documentation' })
vim.keymap.set('n', '<leader>c', ":bdelete<CR>", { buffer = bufnr, desc = '[C]lose buffer' })
vim.keymap.set('n', '<leader>R', ":SnipRun<CR>", { buffer = bufnr, desc = '[R]un code snippet' })
vim.keymap.set('n', '<leader>R', ":SnipRun<CR>", { buffer = bufnr, desc = '[R]un code snippet' })
vim.keymap.set('n', '<leader>z', ":ZenMode<CR>", { buffer = bufnr, desc = '[z]en mode' })
vim.keymap.set('n', '<leader>;b', ":Telescope dap list_breakpoints<CR>",
	{ buffer = bufnr, desc = 'List debug [b]reakpoints' })
vim.keymap.set('n', '<leader>;c', ":Telescope dap commands<CR>", { buffer = bufnr, desc = 'List debug [c]ommands' })
vim.keymap.set('n', '<leader>;C', ":Telescope dap configurations<CR>",
	{ buffer = bufnr, desc = 'List debug [C]onfigurations' })
vim.keymap.set('n', '<leader>;f', ":Telescope dap frames<CR>", { buffer = bufnr, desc = 'List debug [f]rames' })
vim.keymap.set('n', '<leader>;v', ":Telescope dap variables<CR>", { buffer = bufnr, desc = 'List debug [v]ariables' })

-- goto maps
vim.keymap.set('n', 'gh', "^", { buffer = bufnr, desc = 'Goto line start' })
vim.keymap.set('n', 'gl', "$", { buffer = bufnr, desc = 'Goto line end' })
vim.keymap.set('n', 'gn', ":bnext<CR>", { buffer = bufnr, desc = 'Goto buffer [n]ext' })
vim.keymap.set('n', 'gp', ":bprevious<CR>", { buffer = bufnr, desc = 'Goto buffer [p]revious' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto [d]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto [D]eclaration' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'Goto [r]eferences' })
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
	{ buffer = bufnr, desc = 'Goto [i]mplementation' })
vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions,
	{ buffer = bufnr, desc = 'Goto [t]ype Definition' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
