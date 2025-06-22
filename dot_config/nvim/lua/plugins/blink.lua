return {
  { 'L3MON4D3/LuaSnip', keys = {} },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'b0o/schemastore.nvim',
    },
    -- event = "InsertEnter",
    version = '*',
    config = function()
      vim.cmd 'highlight Pmenu guibg=none'
      vim.cmd 'highlight PmenuExtra guibg=none'
      vim.cmd 'highlight FloatBorder guibg=none'
      vim.cmd 'highlight NormalFloat guibg=none'

      require('blink.cmp').setup {
        fuzzy = { implementation = 'prefer_rust' },
        snippets = { preset = 'luasnip' },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = false,
          nerd_font_variant = 'normal',
        },
        sources = {
          default = { 'lsp', 'snippets', 'path', 'buffer' },
          providers = {
            cmdline = {
              min_keyword_length = 3,
            },
          },
        },
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
          ['<C-\\>'] = { 'hide', 'fallback' },
          ['<C-n>'] = { 'select_next', 'show' },
          ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
          ['S-<Tab>'] = { 'select_prev' },
          ['<C-p>'] = { 'select_prev' },
          ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        },
        cmdline = {
          enabled = false,
          completion = { menu = { auto_show = true } },
          keymap = {
            ['<CR>'] = { 'accept_and_enter', 'fallback' },
          },
        },
        completion = {
          menu = {
            border = 'single',
            scrolloff = 1,
            scrollbar = false,
            draw = {
              columns = {
                { 'kind_icon' },
                { 'label', 'label_description', gap = 1 },
                { 'kind' },
                { 'source_name' },
              },
            },
          },
          documentation = {
            window = {
              border = 'single',
              scrollbar = false,
              winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
            },
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },
      }

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
