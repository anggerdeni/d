local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  root = vim.fn.stdpath('data') .. '/lazy', -- directory where plugins will be installed
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
    version = false,
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
  },
  -- TODO: build spec
  spec = {{ import = 'plugins' }}, ---@type LazySpec
  dev = {
    -- TODO: directory where you store your local plugin projects
    path = '~/projects',
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {}, -- For example {'folke'}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'onedark', 'tokyonight', 'habamax' },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        'gzip',
        -- 'matchit',
        -- 'matchparen',
        -- 'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
