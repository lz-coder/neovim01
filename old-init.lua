-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- OPTIONS
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.syntax = "on"
vim.opt.cursorline = true
--vim.opt.filetype.indent = "on"
vim.opt.ttyfast = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- PACKER PLUGIN MANAGER
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end


-- PLUGINS
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { "catppuccin/nvim", as = "catppuccin" }
  use 'mhinz/vim-startify' -- Start screen for vim/nvim
  use 'nvim-lualine/lualine.nvim' -- Status line
  use 'kyazdani42/nvim-web-devicons' -- Some Icons for nvim
  use 'akinsho/bufferline.nvim' -- Tabs like other editors
  use 'lukas-reineke/indent-blankline.nvim' -- Style for identation
  use 'nvim-treesitter/nvim-treesitter'
  use 'akinsho/toggleterm.nvim' -- We can toggle nvim term
  use 'lewis6991/gitsigns.nvim' -- Show git status for edited/removed parts of code/text
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'williamboman/mason.nvim' -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  use 'williamboman/mason-lspconfig.nvim'
  use 'hrsh7th/nvim-cmp' -- autocompletion plugin for nvim
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'windwp/nvim-autopairs' -- A super powerful autopair plugin for Neovim that supports multiple characters.
  use 'windwp/nvim-ts-autotag' -- Use treesitter to autoclose and autorename html tag
  use 'mrshmllow/document-color.nvim' -- Color preview in document
  use 'nvim-tree/nvim-tree.lua'
  use 'nikvdp/ejs-syntax'

  if install_plugins then
	require('packer').sync()
  end
end)

if install_plugins then
  return
end

require('lualine').setup({})
require('bufferline').setup({})
require('gitsigns').setup({})
require('nvim-autopairs').setup({})
require("nvim-tree").setup()

require("document-color").setup ({
	-- Default options
	mode = "background", -- "background" | "foreground" | "single"
})

require('indent_blankline').setup({
  char = '▏',
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  use_treesitter = true,
  show_current_context = false
})

require('nvim-treesitter.configs').setup({
  highlight = {
	  enable = true,
  },
  ensure_installed = {
	'javascript',
	'typescript',
	'tsx',
	'css',
	'json',
	'lua',
	'html',
  },
  autotag = {
	enable = true,
  },
})

require('toggleterm').setup({
  open_mapping = '<C-g>',
  direction = 'horizontal',
  shade_terminals = true
})

----------------------------
---------KEYBINDINGS--------
----------------------------
vim.g.mapleader = ' ' -- Change leader to SPACE KEY

vim.keymap.set('i', 'kk', '<Esc>') -- Map ESC to kk 
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'}) -- save file
vim.keymap.set({'n', 'x'}, 'cp', '"+y') -- copy to clipboard
vim.keymap.set({'n', 'x'}, 'cv', '"+p') -- paste from clipboard
vim.keymap.set({'n', 'x'}, 'x', '"_x') -- Delete without changing the register
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>') -- Select all

-- move line or visually selected block - alt+j/k
vim.keymap.set('i', '<A-j>', '<cmd>:m .+1<cr>') -- UP
vim.keymap.set('i', '<A-k>', '<cmd>:m .-2<cr>') -- DOWN
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>") -- Visual DOWN
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>") -- Visual UP

-- Change split orientation
vim.keymap.set('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
vim.keymap.set('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Move splits using Alt + {h,j,k,l}
 vim.keymap.set('n', '<A-h>', '<C-W>H')
 vim.keymap.set('n', '<A-j>', '<C-W>J')
 vim.keymap.set('n', '<A-k>', '<C-W>K')
 vim.keymap.set('n', '<A-l>', '<C-W>L')

 -- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')			   -- open/close
vim.keymap.set('n', '<leader>f', ':NvimTreeRefresh<CR>')	   -- refresh
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>')	   -- search file

----------------------------------------
------------- LSP CONFIG----------------
----------------------------------------
require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local on_attach = function(client)
  -- document-color config
  if client.server_capabilities.colorProvider then
	-- Attach document colour support
	require("document-color").buf_attach(bufnr)
  end
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
	vim.api.nvim_create_autocmd("BufWritePre", {
	  group = vim.api.nvim_create_augroup("Format", { clear = true }),
	  buffer = bufnr,
	  callback = function() vim.lsp.buf.formatting_seq_sync() end
	})
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- You are now capable!
capabilities.textDocument.colorProvider = {
  dynamicRegistration = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- LSP SETUP ---

lspconfig.emmet_ls.setup({})

lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true
		}, 
		provideFormatter = true
	},
	single_file_support = true
})

lspconfig.eslint.setup({
	root_dir = require("lspconfig").util.root_pattern("")
})

lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})

-- TypeScript / JavaScript
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "typesriptreact", "typescript.tsx", "javascript"},
	cmd = { "typescript-language-server", "--stdio"},
})

-- AUTOCOMPLETION AND LUASNIP
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local luasnip = require('luasnip')
local select_opts = {behavior = cmp.SelectBehavior.Select}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

cmp.setup({
  snippet = {
	expand = function(args)
	  luasnip.lsp_expand(args.body)
	end
  },
  sources = {
	{name = 'path'},
	{name = 'nvim_lsp', keyword_length = 3},
	{name = 'buffer', keyword_length = 3},
	{name = 'luasnip', keyword_length = 2},
  },
  window = {
	documentation = cmp.config.window.bordered()
  },
  formatting = {
	fields = {'menu', 'abbr', 'kind'},
	format = function(entry, item)
	  local menu_icon = {
		nvim_lsp = 'λ',
		luasnip = '⋗',
		buffer = 'Ω',
		path = '🖫',
	  }

	  item.menu = menu_icon[entry.source.name]
	  return item
	end,
  },
  mapping = {
	['<Up>'] = cmp.mapping.select_prev_item(select_opts),
	['<Down>'] = cmp.mapping.select_next_item(select_opts),

	['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
	['<C-n>'] = cmp.mapping.select_next_item(select_opts),

	['<C-u>'] = cmp.mapping.scroll_docs(-4),
	['<C-f>'] = cmp.mapping.scroll_docs(4),

	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({select = false}),

	['<C-d>'] = cmp.mapping(function(fallback)
	  if luasnip.jumpable(1) then
		luasnip.jump(1)
	  else
		fallback()
	  end
	end, {'i', 's'}),

	['<C-b>'] = cmp.mapping(function(fallback)
	  if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	  else
		fallback()
	  end
	end, {'i', 's'}),

	['<Tab>'] = cmp.mapping(function(fallback)
	  local col = vim.fn.col('.') - 1

	  if cmp.visible() then
		cmp.select_next_item(select_opts)
	  elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		fallback()
	  else
		cmp.complete()
	  end
	end, {'i', 's'}),

	['<S-Tab>'] = cmp.mapping(function(fallback)
	  if cmp.visible() then
		cmp.select_prev_item(select_opts)
	  else
		fallback()
	  end
	end, {'i', 's'}),
  },
})

--THEME
vim.cmd('colorscheme catppuccin')

--configure nvim file explorer
--- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 30
-- vim.keymap.set('n', '<F2>', '<cmd>Lexplore<cr>') -- keybiding to open file exploer

--USER COMMANDS
vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})
vim.keymap.set('n', '<leader>r', '<cmd>ReloadConfig<cr>', {desc='Reload nvim config'})

-- AUTOCOMMANDS
local augroup = vim.api.nvim_create_augroup('user_cmds', {clear = true})
vim.api.nvim_create_autocmd('TextYankPost', {
	group = augroup,
	desc = 'Highlight on yank',
	callback = function(event)
		vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
	end
})
