return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones. example
      -- local disable_filetypes = { c = true, cpp = true }
      local disable_filetypes = {}
      return {
        timeout_ms = 2500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,

    formatters = {
      golines = {
        prepend_args = { '-m', '120' },
      },
      terraform = {
        prepend_args = { 'fmt' },
      },

      black = {
        prepend_args = { '--line-length', '79' },
      },
    },
    formatters_by_ft = {
      tex = { 'latexindent' },
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      javascript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      css = { { 'prettierd', 'prettier' } },
      go = { 'golines', 'goimports', 'gofumpt' },
      rust = { 'rustfmt' },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      sql = { 'sql_formatter' },
      terraform = { 'terraform_fmt' },
    },
  },
}
