nnoremap gd :ALEGoToDefinition<CR>
nnoremap gf :ALEFindReference<CR>

let b:ale_linters = [ "xo", "tsserver" ]
let b:ale_fixers = [ "importjs", "xo" ]

