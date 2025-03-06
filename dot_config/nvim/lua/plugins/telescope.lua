return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'someone-stole-my-name/yaml-companion.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, --  pretty icons, but requires a Nerd Font.
    -- { 'nvim-telescope/telescope-frecency.nvim' },
    {
      'danielfalk/smart-open.nvim',
      branch = '0.2.x',
      dependencies = { 'kkharji/sqlite.lua' },
    },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'yaml_schema'
    require('telescope').load_extension 'smart_open'
    -- require('telescope').load_extension 'frecency'

    local builtin = require 'telescope.builtin'
    local map = vim.keymap.set
    map('n', '<leader><leader>', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    map('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    map('n', '<leader>ff', function()
      require('telescope').extensions.smart_open.smart_open { cwd_only = true }
    end, { noremap = true, silent = true })

    -- map('n', '<leader><leader>', function()
    --   builtin.buffers(require('telescope.themes').get_dropdown {
    --     winblend = 0,
    --     previewer = false,
    --   })
    -- end, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    map('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    -- map('n', '<leader>s/', function()
    --   builtin.live_grep {
    --     grep_open_files = true,
    --     prompt_title = 'Live Grep in Open Files',
    --   }
    -- end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    map('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
