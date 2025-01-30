-- Fuzzy finder
return {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    -- https://github.com/nvim-lua/plenary.nvim
    { 'nvim-lua/plenary.nvim' },
    {
      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  opts = {
    defaults = {
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      mappings = {
        i = {
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
          ["<C-x>"] = require("telescope.actions").delete_buffer,
        },
      },
      file_ignore_patterns = {
        "node_modules",
        "yarn.lock",
        ".git",
        ".sl",
        "_build",
        ".next",
      },
      hidden = true,
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
      pickers = {
        live_grep = {
          vimgrep_arguments = table.insert(require("telescope.config").values.vimgrep_arguments, "--fixed-strings"),
        },
      },
    }
  }
}
