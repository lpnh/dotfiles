return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts_extend = { 'sources.default' },
  opts = {
    keymap = { preset = 'default' },

    appearance = { nerd_font_variant = 'mono' },

    completion = {
      list = { selection = { preselect = false } },
      trigger = { show_in_snippet = false },
    },

    sources = {
      default = { 'lsp', 'lazydev', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
        },
        snippets = {
          opts = {
            extended_filetypes = {
              html = { 'loremipsum' },
              markdown = { 'loremipsum' },
              askama = { 'html' },
              rust = { 'html' },
            },
          },
        },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
