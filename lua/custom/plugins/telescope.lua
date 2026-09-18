-- telescope changes to get it to use `hidden=true` or
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sf', function() builtin.find_files { hidden = true } end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sg', function() builtin.live_grep { additional_args = { '--hidden' } } end, { desc = '[S]earch by [G]rep' })

vim.keymap.set(
  'n',
  '<leader>s/',
  function()
    builtin.live_grep {
      hidden = true,
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end,
  { desc = '[S]earch [/] in Open Files' }
)
-- Shortcut for searching your Neovim configuration files
vim.keymap.set(
  'n',
  '<leader>sn',
  function()
    builtin.find_files {
      cwd = vim.fn.stdpath 'config',
      follow = true,
    }
  end,
  { desc = '[S]earch [N]eovim files' }
)
