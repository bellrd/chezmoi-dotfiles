local map = vim.keymap.set
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.diagnostic.config {
  virtual_text = true,
  signs = true,
  underline = false,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = 'rounded',
  },
}

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer navigation
map('n', '<leader>;', vim.cmd.bd, { desc = 'Buffer delete' })
map('n', '<leader>o', vim.cmd.only, { desc = 'Only' })
map('n', 'H', vim.cmd.bp, { desc = 'Buffer previous' })
map('n', 'L', vim.cmd.bn, { desc = 'Buffer next' })

-- Quickfix navigation
map('n', '<a-j>', '<cmd>cnext<CR>zz', { desc = 'Quickfix next' })
map('n', '<a-k>', '<cmd>cprev<CR>zz', { desc = 'Quickfix prev' })
map('n', '-', '<cmd>Oil<CR>')

vim.api.nvim_create_user_command('WWW', 'w !sudo tee > /dev/null %', { force = true })

-- See `:help telescope.builtin`
