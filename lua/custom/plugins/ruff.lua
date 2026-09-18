-- Show ruff rule documentation for the word under the cursor in a floating window
vim.keymap.set('n', '<leader>rr', function()
  local word = vim.fn.expand '<cword>'
  if word == '' then return end

  local output = vim.fn.systemlist('ruff rule ' .. vim.fn.shellescape(word))
  if vim.v.shell_error ~= 0 or #output == 0 then
    vim.notify('No ruff rule found for: ' .. word, vim.log.levels.WARN)
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  vim.bo[buf].filetype = 'markdown'
  vim.bo[buf].modifiable = false

  local width = math.min(80, vim.o.columns - 4)
  local height = math.min(#output, vim.o.lines - 4)
  vim.api.nvim_open_win(buf, true, {
    relative = 'cursor',
    row = 1,
    col = 0,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
    title = ' ruff rule ' .. word .. ' ',
    title_pos = 'center',
  })

  -- Press q or Esc to close the float
  vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = buf, silent = true })
  vim.keymap.set('n', '<Esc>', '<cmd>close<CR>', { buffer = buf, silent = true })
end, { desc = '[R]uff [R]ule for word under cursor' })
