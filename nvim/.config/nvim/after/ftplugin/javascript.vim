" nnoremap gd :ALEGoToDefinition<CR>
" nnoremap gf :ALEFindReference<CR>
nnoremap gd :TernDef<CR>
nnoremap gf :TernRefs<CR>
nnoremap gr :TernRename<CR>

let b:ale_linters = [ "xo", "tsserver" ]
let b:ale_fixers = [ "xo" ]

