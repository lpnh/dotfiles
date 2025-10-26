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
      -- https://github.com/Saghen/blink.cmp/issues/1932
      -- list = { selection = { preselect = false } },
      trigger = { show_in_snippet = false },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
        snippets = {
          score_offset = -5,
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
