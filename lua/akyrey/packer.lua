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
  use 'wbthomason/packer.nvim'
  -- Install Material color theme
  use {
    'kaicataldo/material.vim',
    branch = 'main'
  }
  -- Statusline configuration
  use {
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function ()
      require'akyrey.plugins.lualine'.init()
    end
  }
  -- Provides common configuration for various lsp servers
  use {
    'neovim/nvim-lsp',
    requires = {
      'neovim/nvim-lspconfig',
      'glepnir/lspsaga.nvim',
      -- Tree like structure to display symbols in file based on lsp
      'simrat39/symbols-outline.nvim'
    },
    config = function ()
      require'akyrey.plugins.lsp-config'
    end
  }
  -- Parser generator and parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'romgrk/nvim-treesitter-context'
    },
    run = 'TSUpdate',
    config = function ()
      require'akyrey.plugins.tree-sitter'.init()
    end
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
        'erkrnt/compe-tabnine',
        run = './install.sh'
      },
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ'
    },
    config = function ()
      require'akyrey.plugins.compe'.init()
      require'akyrey.plugins.compe_tabnine'.init()
    end
  }
  -- Fuzzy finder over list
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-telescope/telescope-fzy-native.nvim'
    },
    config = function ()
      require'akyrey.plugins.telescope'.init()
    end
  }
  -- Mark and easily navigate through files
  use 'ThePrimeagen/harpoon'
  -- Formatter
  use 'sbdchd/neoformat'
  -- Git management
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'
  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require'akyrey.plugins.gitsigns'.init()
    end
  }
  use {
    'ThePrimeagen/git-worktree.nvim',
    config = function ()
      require'akyrey.plugins.git_worktree'.init()
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
end

return {
  init = init
}

