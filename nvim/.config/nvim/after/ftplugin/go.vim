" Settings {{{
set noexpandtab
set softtabstop=8
set shiftwidth=8

set foldmethod=syntax

let g:go_gocode_propose_source = 0
let g:go_gocode_unimported_packages = 1
let g:go_test_show_name = 0
let g:go_info_mode = 'guru'
let g:go_fmt_command = 'goimports'
let g:go_updatetime = 100
let g:go_metalinter_autosave = 0
let g:go_list_autoclose = 1
let g:go_term_enabled = 1
let g:go_decls_mode = 'fzf'
let g:go_list_type = 'quickfix'
let g:go_template_autocreate = 0
let g:go_fmt_fail_silently = 0
let s:parse_guru_output = 'fzf'
let g:go_decls_includes = "func,type"

" Croutch for gocode
augroup gocodecroutch
  autocmd!
  autocmd BufWritePost *.go silent! :GoBuild -i
augroup END
" }}}
" Keys {{{
nnoremap <leader>T :GoTestFunc<CR>
nnoremap <leader>t :GoTest<CR>
nnoremap <leader>i :GoImport<Space>
nnoremap <leader>I :GoImportAs<Space>
nnoremap <leader>a :GoAlternate<CR>
nnoremap <leader>b :GoBuild<CR>

nnoremap <leader>p :DlvToggleBreakpoint<CR>
nnoremap <leader>d :DlvTest<CR>
" }}}
" ALE {{{
let b:ale_go_golangci_lint_options = "--fast"
let b:ale_go_golangci_lint_package = 1
let b:ale_linters = [
			\ 'golangci-lint',
			\]
let b:ale_fixers = ['goimports']
" }}}
" vim:foldmethod=marker:foldlevel=0
