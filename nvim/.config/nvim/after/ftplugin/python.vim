" ALE {{{
let b:ale_linters = [
      \ 'flake8',
      \]
let b:ale_fixers = [
      \ 'autopep8',
      \ 'black',
      \ 'isort',
      \ 'yapf',
      \ 'add_blank_lines_for_python_control_statements',
      \ 'remove_trailing_lines',
      \ 'trim_whitespace',
      \ ]

let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 1
" }}}
