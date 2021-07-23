local cmd = vim.api.nvim_command
local fn = vim.fn
local packer = nil

local function packer_verify()
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path })
    cmd 'packadd packer.nvim'
  end
end

local function packer_startup()
  if packer == nil then
    packer = require'packer'
    packer.init()
  end

  local use = packer.use
  packer.reset()

  -- Packer can manage itself
  use {
    'wbthomason/packer.nvim',
    event = 'VimEnter'
  }
  -- Install Material color theme
  use {
    'kaicataldo/material.vim',
    branch = 'main',
    after = 'packer.nvim',
    config = function ()
      require'akyrey.plugins.material'.init()
    end
  }
  -- Statusline configuration
  use {
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    after = 'material.vim',
    config = function ()
      require'akyrey.plugins.lualine'.init()
    end
  }
  -- Provides common configuration for various lsp servers
  use {
    'neovim/nvim-lsp',
    requires = {
      {
        'neovim/nvim-lspconfig',
        -- after = 'nvim-lspinstall'
      },
      'glepnir/lspsaga.nvim',
      -- Tree like structure to display symbols in file based on lsp
      'simrat39/symbols-outline.nvim'
    },
    config = function ()
      require'akyrey.plugins.lsp-config'
    end
  }
  use {
    'kabouzeid/nvim-lspinstall',
    -- event = 'BufRead'
  }
  -- Parser generator and parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    event = 'BufRead',
    config = function ()
      require'akyrey.plugins.treesitter'.init()
    end
  }
  use {
    'romgrk/nvim-treesitter-context',
    requires = 'nvim-treesitter/nvim-treesitter',
    event = 'BufRead'
  }
  -- Comment multiple lines
  use 'tpope/vim-commentary'
  -- Highlight todos
  use {
    'folke/todo-comments.nvim',
    config = function ()
      require'akyrey.plugins.todo-comments'.init()
    end
  }
  -- Auto completion and snippets
  use {
    'hrsh7th/nvim-compe',
    requires = {
      {
        'L3MON4D3/LuaSnip',
        wants = 'friendly-snippets',
        event = 'InsertCharPre',
        config = function()
          require'akyrey.plugins.luasnip'.init()
        end
      },
      {
        'rafamadriz/friendly-snippets',
        event = 'InsertCharPre'
      }
    },
    event = 'InsertEnter',
    wants = 'LuaSnip',
    config = function ()
      require'akyrey.plugins.compe'.init()
    end
  }
  use {
    'erkrnt/compe-tabnine',
    requires = {
      'hrsh7th/nvim-compe',
    },
    event = 'InsertEnter',
    run = './install.sh',
    config = function ()
      require'akyrey.plugins.compe_tabnine'.init()
    end
  }
  -- Fuzzy finder over list
  use {
    'nvim-lua/plenary.nvim',
  }
  use {
    'nvim-lua/popup.nvim',
    requires = 'nvim-lua/plenary.nvim'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-fzy-native.nvim',
      {
        'ThePrimeagen/git-worktree.nvim',
        requires = {
          'nvim-lua/plenary.nvim',
        },
        config = function ()
          require'akyrey.plugins.git-worktree'.init()
        end
      }
    },
    requires = 'nvim-lua/popup.nvim',
    config = function ()
      require'akyrey.plugins.telescope'.init()
    end
  }
  -- Mark and easily navigate through files
  use {
    'ThePrimeagen/harpoon',
    requires = {
      'nvim-lua/popup.nvim',
    },
  }
  -- Formatter
  use 'sbdchd/neoformat'
  -- Git management
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      require'akyrey.plugins.gitsigns'.init()
    end
  }
  -- Man page inside vim
  use 'vim-utils/vim-man'
  -- Visualize undo history
  use 'mbbill/undotree'
  -- Metrics, insights and time tracking
  use 'wakatime/vim-wakatime'
end

local function init()
  packer_verify()
  packer_startup()
  vim.cmd[[autocmd BufWritePost lua/akyrey/packer.lua source <afile> | PackerSync]]
end

return {
  init = init
}

