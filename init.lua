if vim.g.vscode then
	os.exit()
end

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
	-- language support
	{
		"mfussenegger/nvim-lint",
		config = function()
			require('lint').linters_by_ft = {
				go = { 'golangcilint', }
			}
		end
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()'
	},
	{ 'michaelb/sniprun',              build = 'bash ./install.sh' },

	-- UI
	{ 'kvrohit/mellow.nvim' },
	{ "stevearc/dressing.nvim",        event = "VeryLazy" },
	{ "xiyaowong/telescope-emoji.nvim" },
	{
		'kevinhwang91/nvim-hlslens',
		config = function()
			require('hlslens').setup()
		end
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup {}
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "»",
			show_trailing_blankline_indent = false,
		},
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
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
		'echasnovski/mini.indentscope',
		version = false,
		config = function()
			require('mini.indentscope').setup()
		end
	},
	{ "RRethy/vim-illuminate" },
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require('scrollbar').setup({
				handlers = {
					search = true,
				}
			})
		end
	},
	{ "folke/which-key.nvim", opts = {} },
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = false,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_c = {
					{
						'filename',
						path = 1,
					}
				},
			}
		},
	},
	{
		'folke/tokyonight.nvim',
		config = function()
			require('tokyonight').setup({
				style = "night",
				on_colors = function(colors)
					colors.bg = "#0a0a0d"
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
		config = function()
			require("gitsigns").setup()
		end
	},
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{
		'kevinhwang91/nvim-ufo',
		dependencies = 'kevinhwang91/promise-async',
		config = function()
			require('ufo').setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { 'treesitter', 'indent' }
				end
			})
			vim.o.foldlevel = 100000 -- what the fuck, neovim plugins just suck soooooooooo much
		end
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		'echasnovski/mini.pairs',
		version = false,
		config = function()
			require('mini.pairs').setup()
		end
	},
	{ 'kevinhwang91/nvim-bqf' },

	-- motions
	{
		"ggandor/leap.nvim",
		config = function()
			require('leap').add_default_mappings()
		end
	},
	{
		"ggandor/flit.nvim",
		config = function()
			require('flit').setup {
				multiline = true
			}
		end
	},
	{ 'mg979/vim-visual-multi',              branch = 'master' },
	{ 'ThePrimeagen/harpoon' },

	-- etc
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-completion" },
	{ "kristijanhusak/vim-dadbod-ui" },
	{ "folke/neodev.nvim",                   opts = {} },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-surround" },
	--{
	--	'codota/tabnine-nvim',
	--	build = "./dl_binaries.sh",
	--	config = function()
	--		require('tabnine').setup({
	--			accept_keymap = "<C-x>",
	--			exclude_filetypes = { "TelescopePrompt" },
	--		})
	--	end
	--},
	{ "APZelos/blamer.nvim" },
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
		"cshuaimin/ssr.nvim",
		config = function()
			require("ssr").setup {
				border = "rounded",
				min_width = 50,
				min_height = 5,
				max_width = 120,
				max_height = 25,
				keymaps = {
					close = "q",
					next_match = "n",
					prev_match = "N",
					replace_confirm = "<CR>",
					replace_all = "<leader><cr>",
				},
			}
		end
	},
	{ "Marskey/telescope-sg" },

	-- core
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			telescope.setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = 'top',
					},
					mappings = {
						i = {
							--["<esc>"] = actions.close,
							["<C-a>"] = actions.toggle_selection,

							["<Tab>"] = actions.move_selection_next,
							["<S-Tab>"] = actions.move_selection_previous,

							-- doesn't work for some reason
							-- ["<Down>"] = actions.toggle_selection + actions.move_selection_worse,
							-- ["<Up>"] = actions.toggle_selection + actions.move_selection_better,
						},
					},
					preview = { ls_short = true },
				},
				pickers = {
					buffers = {
						mappings = {
							i = {
								["<A-d>"] = actions.delete_buffer
							}
						}
					},
				},
				extensions = {
					file_browser = {
						grouped = true,
						dir_icon = "󰉋",
						preview = { ls_short = true },
						hidden = { file_browser = true, folder_browser = true },
					},
					ast_grep = {
						command = { "ast-grep", "--json=stream" },
						grep_open_files = false,
						lang = nil,
					}
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("emoji")
			telescope.load_extension('ast_grep')
		end
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim",          config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "j-hui/fidget.nvim",                opts = {},    tag = "legacy" },
			{ "folke/neodev.nvim" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer", "hrsh7th/cmp-calc", "hrsh7th/cmp-path" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
	},
})


-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set tab size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

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

vim.wo.wrap = true
vim.wo.linebreak = true
--vim.wo.list = false

vim.o.termguicolors = true

vim.opt.colorcolumn = "80"

vim.g.netrw_keepdir = 0
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
vim.opt.shell = 'fish'

-- Set backups
vim.opt.backupdir = '/home/rw_panic0_0/.backup/nvim/'
vim.opt.backup = true
vim.api.nvim_create_autocmd('BufWritePre', {
	group = vim.api.nvim_create_augroup('timestamp_backupext', { clear = true }),
	desc = 'Add timestamp to backup extension',
	pattern = '*',
	callback = function()
		vim.opt.backupext = '-' .. vim.fn.strftime('%Y%m%d%H%M')
	end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	callback = function()
		require("lint").try_lint()
	end
})

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

local on_attach = function(_, _)
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
		{ name = "buffer" },
		{ name = 'calc' },
		{ name = 'path' }
	},
	sorting = {
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.kind,
			-- compare.scopes,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			-- compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		}
	}
})


-- space maps
vim.keymap.set("n", "<leader>f", ":Telescope file_browser path=%:p:h<CR>", { noremap = true, desc = "[f]ile browser" })
--vim.keymap.set("n", "<leader>f", ":Explore<cr>", { noremap = true, desc = "[f]ile browser" })
vim.keymap.set("n", "<leader>b", ":Telescope buffers<CR>", { noremap = true, desc = "[b]uffers" })
vim.keymap.set("n", "<leader>D", ":Telescope diagnostics<CR>",
	{ noremap = true, desc = "[D]iagnostics list" })
vim.keymap.set("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", { noremap = true, desc = "Document [s]ymbols" })
vim.keymap.set("n", "<leader>S", ":Telescope lsp_workspace_symbols<CR>", { noremap = true, desc = "Workspace [S]ymbols" })
vim.keymap.set("n", "<leader>l", ":Telescope live_grep<CR>", { noremap = true, desc = "[l]ive grep" })
vim.keymap.set("n", "<leader>L", ":Telescope ast_grep<CR>", { noremap = true, desc = "AST grep" })
vim.keymap.set("n", "<leader>F", ":Telescope filetypes theme=dropdown<CR>", { noremap = true, desc = "[F]iletypes list" })
vim.keymap.set('n', '<leader>N', ":Noice telescope<CR>", { buffer = bufnr, desc = '[N]otification history' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Hover [d]iagnostic" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostic list" })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP [r]ename' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP Code [a]ction' })
vim.keymap.set('n', '<leader>1a', ':Telescope commands default_text=Go theme=cursor<CR>',
	{ buffer = bufnr, desc = 'Golang code [a]ction' })
vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP Hover Documentation' })
vim.keymap.set('n', '<leader>c', ":bdelete<CR>", { buffer = bufnr, desc = '[c]lose buffer' })
vim.keymap.set('n', '<leader>C', ":bdelete!<CR>", { buffer = bufnr, desc = '[C]lose buffer (unsaved)' })
vim.keymap.set('n', '<leader>n', ":enew<CR>", { buffer = bufnr, desc = '[n]ew tab' })
vim.keymap.set('n', '<leader>R', ":SnipRun<CR>", { buffer = bufnr, desc = '[R]un code snippet' })
vim.keymap.set('v', '<leader>R', ":SnipRun<CR>", { buffer = bufnr, desc = '[R]un code snippet' })
vim.keymap.set('n', '<leader>z', ":ZenMode<CR>", { buffer = bufnr, desc = '[z]en mode' })
vim.keymap.set('n', '<leader>sr', require("ssr").open, { buffer = bufnr, desc = 'Structured [s]earch and [r]eplace' })
vim.keymap.set('n', '<leader>o', 'o<Esc>0"_D', { buffer = bufnr, desc = 'New line below' })
vim.keymap.set('n', '<leader>O', 'O<Esc>0"_D', { buffer = bufnr, desc = 'New line above' })
vim.keymap.set('n', '<leader>sr', require("ssr").open, { buffer = bufnr, desc = 'Structured [s]earch and [r]eplace' })
vim.keymap.set('n', '<leader>gb', ':BlamerToggle<CR>', { buffer = bufnr, desc = '[g]it [b]lame' })

-- harpoon
vim.keymap.set('n', ',.', ':lua require("harpoon.ui").toggle_quick_menu()<cr>',
	{ buffer = bufnr, desc = '[h]arpoon menu' })
vim.keymap.set('n', ',m', ':lua require("harpoon.mark").add_file()<cr>',
	{ buffer = bufnr, desc = '[h]arpoon mark' })
vim.keymap.set('n', ',n', ':lua require("harpoon.ui").nav_next()<cr>',
	{ buffer = bufnr, desc = '[h]arpoon next' })
vim.keymap.set('n', ',p', ':lua require("harpoon.ui").nav_prev()<cr>',
	{ buffer = bufnr, desc = '[h]arpoon prev' })

-- goto maps
vim.keymap.set('n', 'gn', ":bnext<CR>", { buffer = bufnr, desc = 'Goto buffer [n]ext' })
vim.keymap.set('n', 'gp', ":bprevious<CR>", { buffer = bufnr, desc = 'Goto buffer [p]revious' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto [d]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto [D]eclaration' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = bufnr, desc = 'Goto [r]eferences' })
vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
	{ buffer = bufnr, desc = 'Goto [i]mplementation' })
vim.keymap.set('n', 'gt', require('telescope.builtin').lsp_type_definitions,
	{ buffer = bufnr, desc = 'Goto [t]ype Definition' })

-- remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', 'H', "^", { buffer = bufnr })
vim.keymap.set('n', 'L', "$", { buffer = bufnr })
vim.keymap.set('n', 'K', "gg", { buffer = bufnr })
vim.keymap.set('n', 'J', "G", { buffer = bufnr })

vim.keymap.set('n', '<C-e>', '3<C-e>', { buffer = bufnr })
vim.keymap.set('n', '<C-y>', '3<C-y>', { buffer = bufnr })

vim.keymap.set('v', '<leader>jj', ':!jq<cr>:setfiletype json<cr>', { buffer = bufnr, desc = '' })
vim.keymap.set('v', '<leader>jk', ':!jq -r tostring<cr>:setfiletype json<cr>', { buffer = bufnr, desc = '' })
