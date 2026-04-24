return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  branch = 'v1',
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts = {
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
              askama = { 'loremipsum', 'html' },
            },
          },
        },
      },
    },
  },
}
