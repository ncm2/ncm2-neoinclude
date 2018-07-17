"=============================================================================
" FILE: ncm2_neoinclude.vim
" AUTHOR:  Jia Sui <jsfaint@gmail.com>
" License: MIT license
" ============================================================================

function! ncm2_neoinclude#on_complete(ctx) abort
  let typed = a:ctx['typed']

  let startcol =  neoinclude#file_include#get_complete_position(typed)

  if startcol == -1
    return
  endif

  let inc = neoinclude#file_include#get_include_files(typed)

  let matches = map(inc, "{'word': v:val['word'], 'dup': 1, 'icase': 1, 'menu': 'FI: ' . v:val['kind']}")

  call ncm2#complete(a:ctx, startcol + 1, matches)
endfunction

function! ncm2_neoinclude#init() abort
 call ncm2#register_source({ 'name': 'neoinclude',
      \ 'mark': 'FI',
      \ 'priority': 8,
      \ 'on_complete': 'ncm2_neoinclude#on_complete',
      \ 'complete_length': 1,
      \ })
endfunction
