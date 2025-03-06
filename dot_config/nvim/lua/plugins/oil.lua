return {
  'stevearc/oil.nvim',
  opts = {
    skip_confirm_for_simple_edits = true,
    default_file_explorer = true,
    buf_options = {
      buflisted = false,
      bufhidden = 'hide',
    },
    win_options = {
      wrap = false,
      signcolumn = 'no',
      cursorcolumn = false,
      foldcolumn = '0',
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = 'nvic',
    },

    columns = {
      -- "permissions",
      'size',
      'icon',
      -- "mtime",
    },
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['yp'] = 'actions.copy_entry_path',
    },
  },
}
