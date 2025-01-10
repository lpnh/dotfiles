return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts_extend = { 'sources.default' },
  opts = {
    keymap = { preset = 'default' },

    appearance = { nerd_font_variant = 'mono' },

    completion = {
      menu = { border = 'rounded' },
      documentation = { window = { border = 'rounded' } },
      list = { selection = { preselect = false } },
      trigger = { show_in_snippet = false },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        snippets = {
          score_offset = -5,
          opts = {
            extended_filetypes = {
              html = { 'loremipsum' },
              markdown = { 'loremipsum' },
              rust = { 'html' },
            },
          },
        },
      },
    },
  },
}
