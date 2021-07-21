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
  use 'hoob3rt/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  -- Provides common configuration for various lsp servers
  use 'neovim/nvim-lsp'
  use 'neovim/nvim-lspconfig'
  use 'lspcontainers/lspcontainers.nvim'
  use 'glepnir/lspsaga.nvim'
  -- Tree like structure to display symbols in file based on lsp
  use 'simrat39/symbols-outline.nvim'
  -- Parser generator and parsing library
  use 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
  use 'romgrk/nvim-treesitter-context'
  -- Comment multiple lines
  use 'tpope/vim-commentary'
  -- Highlight todos
  use 'folke/todo-comments.nvim'
  -- Auto completion and snippets
  use 'hrsh7th/nvim-compe'
  use 'akyrey/compe-tabnine', { 'do': './install.sh' }
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  -- Fuzzy finder over list
  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  -- Mark and easily navigate through files
  use 'ThePrimeagen/harpoon'
  -- Formatter
  use 'sbdchd/neoformat'
  -- Git management
  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'
  use 'lewis6991/gitsigns.nvim'
  use 'ThePrimeagen/git-worktree.nvim'
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

