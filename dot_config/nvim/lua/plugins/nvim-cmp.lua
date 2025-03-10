local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

return {
  'hrsh7th/nvim-cmp',
  lazy = false,
  priority = 100,
  dependencies = {
    'onsails/lspkind.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-calc',
    {
      'L3MON4D3/LuaSnip',
      build = 'make install_jsregexp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = function()
        require('luasnip/loaders/from_vscode').lazy_load()
      end,
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp-signature-help',
  },
  config = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect' }
    vim.opt.shortmess:append 'c'
    local lspkind = require 'lspkind'
    lspkind.init {}

    local cmp = require 'cmp'

    cmp.setup {
      preselect = 'None',
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp-signature_help' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'path' },
        { name = 'calc' },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-y>'] = cmp.mapping(
          cmp.mapping.confirm {
            behavior = cmp.SelectBehavior.Insert,
            select = true,
          },
          { 'i', 'c' }
        ),

        ['<CR>'] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }, { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      },

      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
    }

    local ls = require 'luasnip'
    ls.config.set_config {
      history = false,
      updateevents = 'TextChanged,TextChangedI',
    }

    vim.keymap.set({ 'i', 's' }, '<c-k>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<c-j>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })
  end,
}
