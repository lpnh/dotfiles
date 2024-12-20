return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = 'v0.*',
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts_extend = { 'sources.default' },
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'mono',
    },

    completion = {
      menu = { border = 'rounded' },
      documentation = {
        window = { border = 'rounded' },
      },
      list = { selection = 'manual' },
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
