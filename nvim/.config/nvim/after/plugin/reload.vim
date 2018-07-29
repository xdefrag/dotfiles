augroup VimReload
  autocmd!
  autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END
