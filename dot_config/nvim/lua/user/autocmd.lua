-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- close some temporary window with q
local group = vim.api.nvim_create_augroup('UserConfig', { clear = true })
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   group = group,
--   desc = "keymap 'q' to close help/quickfix/netrw/etc windows",
--   pattern = { 'help', 'qf', 'netrw', 'httpResult', 'nofile' },
--   callback = function()
--     vim.keymap.set('n', 'q', '<C-w>c', { buffer = true, desc = 'Quit (or Close) help, quickfix, netrw, etc windows' })
--   end,
-- })
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = group,
  desc = "Keymap 'q' to close help/quickfix/netrw/etc windows",
  callback = function()
    local buftype = vim.bo.buftype
    if buftype == 'help' or buftype == 'quickfix' or buftype == 'netrw' or buftype == 'nofile' then
      vim.keymap.set('n', 'q', '<C-w>c', { buffer = true, desc = 'Quit (or Close) help, quickfix, netrw, etc windows' })
    end
  end,
})

-- Open files at the last cursor position it was edited
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'open file at the last position it was edited earlier',
  group = group,
  pattern = '*',
  command = 'silent! normal! g`"zv',
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GitConflictDetected',
  callback = function()
    vim.notify('GitConflictDetected: ct => choose their,  co => choose ours, cb => choose both; ]x => prev, [x => next', vim.log.levels.INFO)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'http',
  callback = function()
    vim.keymap.set('n', 'K', function()
      require('moo').run()
    end)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  group = group,
  callback = function()
    vim.keymap.set('n', '<leader>x', ':!python %<CR>', { noremap = true, silent = true, buffer = true })
    vim.keymap.set('v', '<leader>x', ":'<,'>w !python<CR>", { noremap = true, silent = true, buffer = true })
  end,
})
