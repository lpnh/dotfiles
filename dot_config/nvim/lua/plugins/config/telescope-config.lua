-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		prompt_prefix = " 🔍 ",
		selection_caret = "  ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = { "node_modules" },
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		path_display = { "truncate" },
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-enter>"] = "to_fuzzy_refine",
			},
		},
	},
	pickers = {
		buffers = {
			--     initial_mode = "insert",
			ignore_current_buffer = true,
			sort_lastused = true,
			theme = "ivy",
			previewer = false,
			--     -- layout_config = {
			--     --   width = 115,
			--     --   height = 22,
			--     -- },
		},
		--   find_files = {
		--     theme = "ivy",
		--     layout_strategies = "vertical",
		--     layout_config = {
		--       height = 11,
		--     },
		--     hidden = true,
		--   },
		--   git_files = {
		--     theme = "ivy",
		--     layout_strategies = "vertical",
		--     layout_config = {
		--       height = 11,
		--     },
		--     hidden = true,
		--   },
		--   grep_string = {
		--     prompt_prefix = "🔍 ",
		--     no_ignore = true,
		--     file_ignore_patterns = { "%.png", "%.jpg", "%.jpeg", "%.gif", "%.webp", "%.svg" },
		--   },
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			override_live_grep_sorter = true,
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

-- Enable telescope extensions, if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>E", builtin.buffers, { desc = "Find [E]xisting Buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- Also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Custom search chezmoi files
local function search_chezmoi()
	builtin.find_files({
		prompt_title = "ChezmoiDir",
		cwd = "~/.local/share/chezmoi",
	})
end

vim.api.nvim_create_user_command("ChezmoiDir", search_chezmoi, {})

vim.keymap.set("n", "<leader>sc", search_chezmoi, { desc = "[S]earch [C]hezmoi" })
