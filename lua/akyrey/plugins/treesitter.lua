local function init()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'bash',
      'css',
      'dockerfile',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'lua',
      'tsx',
      'typescript',
    },
    highlight = {
      enable = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = {
      enable = true
    },
  }
end

return {
  init = init,
}
