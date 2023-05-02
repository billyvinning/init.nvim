call plug#begin()
Plug 'tpope/vim-surround'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'Yggdroot/indentLine'
Plug 'preservim/nerdcommenter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'petertriho/nvim-scrollbar'
call plug#end()


lua << END
require('gitsigns').setup()
require("bufferline").setup{}
require('lualine').setup{options = { theme  = 'gruvbox-material'}}
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "bashls", "clangd", "jsonls", "texlab", "jedi_language_server", "yamlls"}
})
local cmp = require('cmp')

require'cmp'.setup {
  sources = {
      { name = 'nvim_lsp' }, {name = 'path'}, {name = 'buffer' } 
  },
  mapping = {
    -- other mappings
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i" }),
  }
}


local capabilities = require('cmp_nvim_lsp').default_capabilities()

require'lspconfig'.bashls.setup {
  capabilities = capabilities,
}

require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}

require'lspconfig'.texlab.setup {
  capabilities = capabilities,
}

require'lspconfig'.jedi_language_server.setup {
  capabilities = capabilities,
}

require'lspconfig'.yamlls.setup {
  capabilities = capabilities,
}
require("scrollbar").setup()


-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
  contrast = "hard", -- can be "hard", "soft" or empty string
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "bash", "c", "cpp", "gitignore", "json", "latex", "lua", "make", "python", "rst", "yaml", "vim", "vimdoc" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

root_dir = function() return vim.loop.cwd() end
END

set termguicolors
set number
set background=dark " or light if you want light mode
colorscheme gruvbox
"set tabstop=4               " number of columns occupied by a tab 
"set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
"set expandtab               " converts tabs to white space
"set shiftwidth=4            " width for autoindents
"set autoindent              " indent a new line the same amount as the line just typed
filetype plugin on
