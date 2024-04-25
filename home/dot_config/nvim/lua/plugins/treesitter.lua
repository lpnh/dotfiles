return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nushell/tree-sitter-nu',
  },
  build = ':TSUpdate',
}
