-- Change cursor to original after exiting vim
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.api.nvim_command('set guicursor= | call chansend(v:stderr, "\x1b[ q")')
  end
})