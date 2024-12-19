return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets', 'saghen/blink.compat' },
  build = 'cargo build --release',
  event = 'InsertEnter',
  opts_extend = {
    'sources.compat',
    'sources.completion.enabled_providers',
    'sources.default',
  },
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    completion = {
      menu = { border = 'rounded' },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'rounded' },
      },
    },
  },
}
