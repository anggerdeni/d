return {
    -- themes
    {
        'navarasu/onedark.nvim',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    -- {
    --     'folke/tokyonight.nvim',
    --     lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    -- }

    -- git related
    { 'tpope/vim-fugitive' },
    { 'lewis6991/gitsigns.nvim' },

    -- LSP
    -- { 'williamboman/mason.nvim' },
    -- { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v4.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { 'ray-x/lsp_signature.nvim' },
    { 'nvimtools/none-ls.nvim' },
    { 'jay-babu/mason-null-ls.nvim' },

    { 'folke/neodev.nvim' },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    { "lukas-reineke/indent-blankline.nvim",      main = "ibl",                                                                                                                          opts = {} },
    { 'nvim-lualine/lualine.nvim' }, -- Fancier statusline
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },

    { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

    { 'mfussenegger/nvim-lint' },
    { 'xiyaowong/nvim-transparent' },
    { 'theprimeagen/harpoon' },
    { 'mbbill/Undotree' },

    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    -- plugins/rest.lua
    -- {
    --     "vhyrro/luarocks.nvim",
    --     priority = 1000,
    --     config = true,
    -- },
    -- {
    --     "rest-nvim/rest.nvim",
    --     ft = "http",
    --     dependencies = { "luarocks.nvim" },
    --     config = function()
    --         require("rest-nvim").setup()
    --     end,
    -- },

    -- md related stuffs
    { 'vim-pandoc/vim-pandoc' },
    { "vim-pandoc/vim-pandoc-syntax" },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- note taking
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- Optionals
            "hrsh7th/nvim-cmp",
        },
    }
}
