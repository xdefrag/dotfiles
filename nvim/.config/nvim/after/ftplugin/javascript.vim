" setlocal makeprg=npx\ xo\ --reporter=unix\ %

" augroup compiler
"   autocmd!
"   autocmd BufWrite *.js silent make | cw
" augroup END
