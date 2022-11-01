" Utils.vim
"
" Various utility functions


function! runwithme#utils#GetNearestFuncName() abort
  " get the the nearest func aboves name and return it
  let view = winsaveview()
  normal! [[0w
  let func_name = expand('<cword>')
  call winrestview(view)
  return func_name
endfunction


function! runwithme#utils#CheckVersion() abort
  " warn user of incompatibility
  try
    if has('nvim')
      return
    elseif v:version < 802
      throw 'invalid version'
    endif
  catch /.*invalid version/
    " use of default args supported in 8.1.13 or above
    echoerr 'This plugin only supports vim >= 8.2'
  endtry
endfunction


function! runwithme#utils#RemovePreExistingBuffer(cmd) abort
  " deletes buffers containing previous script executions
  " a:cmd (str): previously run command (used to find buffer)
  let name = has('nvim') == 1 ? a:cmd : '!' . a:cmd
  for bufinfo in getbufinfo()
    if bufinfo.name =~# name && bufexists(bufinfo.bufnr)
      execute 'silent! bd! ' . bufinfo.bufnr
    endif
  endfor
endfunction


function! runwithme#utils#GetVisualSelection() abort
  " return current or previous text selected in visual mode
  let start = getpos("'<")[1]
  let end = getpos("'>")[1]
  return getline(start, end)
endfunction
