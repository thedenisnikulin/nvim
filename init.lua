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
	{ 'mg979/vim-visual-multi',                 branch = 'master' },
	{ 'echasnovski/mini.indentscope',           version = false },
	{ 'echasnovski/mini.pairs',                 version = false },
	{ "xiyaowong/telescope-emoji.nvim" },
	{ "RRethy/vim-illuminate" },
	{ "ggandor/leap.nvim" },
	{ "ggandor/flit.nvim" },
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{ "numToStr/Comment.nvim",                  opts = {} },
	"tpope/vim-sleuth",
	{ "folke/which-key.nvim",   opts = {} },
	"tpope/vim-surround",
	{ "karb94/neoscroll.nvim" },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	{ "folke/noice.nvim",       dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", } },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	{
		-- LSP Configuration & Plugins
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

require("telescope").load_extension("file_browser")
require("telescope").load_extension("emoji")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
			},
		},
	},
})

require('mini.indentscope').setup()
require('mini.pairs').setup()
require('leap').add_default_mappings()
require('flit').setup {
	keys = { f = 'f', F = 'F', t = 't', T = 'T' },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "v",
	multiline = true,
	-- Like `leap`s similar argument (call-specific overrides).
	-- E.g.: opts = { equivalence_classes = {} }
	opts = {}
}
require('neoscroll').setup()
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
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
-- vim.o.undofile = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
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

vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])


require("keys")
