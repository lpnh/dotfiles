return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- If encountering errors, see telescope-fzf-native README
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        prompt_prefix = ' 🔍 ',
        selection_caret = '󰼛 ',
        entry_prefix = '  ',
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            -- preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { 'node_modules' },
        path_display = { 'truncate' },
        winblend = 0,
        mappings = {
          i = {
            ['<esc>'] = require('telescope.actions').close,
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-k>'] = require('telescope.actions').preview_scrolling_up,
            ['<C-j>'] = require('telescope.actions').preview_scrolling_down,
            ['<C-enter>'] = 'to_fuzzy_refine',
          },
        },
      },
      pickers = {
        buffers = {
          -- initial_mode = "insert",
          ignore_current_buffer = true,
          sort_lastused = true,
          theme = 'ivy',
          previewer = false,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          override_live_grep_sorter = true,
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>s?', builtin.help_tags, { desc = 'Search help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>sb', builtin.builtin, { desc = 'Search telescope builtin' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search word under the cursor' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<leader>sh', builtin.oldfiles, { desc = 'Search in recent files' })
    vim.keymap.set('n', '<leader>ssd', builtin.builtin, { desc = 'Search symbols in document' })
    vim.keymap.set('n', '<leader>ssw', builtin.builtin, { desc = 'Search symbols in workspace' })

    vim.keymap.set('n', '<Tab>', function()
      builtin.buffers(require('telescope.themes').get_ivy {
        ignore_current_buffer = false,
        layout_config = { height = 0.25 },
        path_display = { 'tail' },
      })
    end, { desc = 'Find existing buffers' })

    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = 'Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Search in open files' })

    local function search_neovim_config()
      -- Shortcut for searching your Neovim configuration files
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end

    vim.keymap.set('n', '<leader>sn', search_neovim_config, { desc = 'Search neovim config' })

    vim.api.nvim_create_user_command('NeovimConfig', search_neovim_config, {})
  end,
}
