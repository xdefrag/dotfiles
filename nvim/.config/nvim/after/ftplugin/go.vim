" Settings {{{
set noexpandtab
set softtabstop=8
set shiftwidth=8

set foldmethod=syntax

let g:go_gocode_unimported_packages = 0
let g:go_test_show_name = 0
let g:go_info_mode = 'guru'
let g:go_fmt_command = 'goimports'
let g:go_updatetime = 100
let g:go_metalinter_autosave = 1
let g:go_list_autoclose = 1
let g:go_term_enabled = 1
let g:go_decls_mode = 'ctrlp.vim'
let g:go_list_type = ''
let g:go_template_autocreate = 0
let g:go_fmt_fail_silently = 0
" }}}
" Keys {{{
nnoremap <localleader>T :GoTestFunc<CR>
nnoremap <localleader>t :GoTest<CR>
nnoremap <localleader>i :GoImport<Space>
nnoremap <localleader>I :GoImportAs<Space>
nnoremap <localleader>a :GoAlternate<CR>
nnoremap <localleader>b :GoBuild<CR>
" }}}
" vim:foldmethod=marker:foldlevel=0
