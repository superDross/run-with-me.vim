" run-with-me.vim - Run With Me
" Author:      David Ross <https://github.com/superDross/>
" Version:     0.01


if exists('g:runner_rowsize') ==# 0
  let g:runner_rowsize = 15
endif


if exists('g:runner_extensions') ==# 0
  let g:runner_extensions = {
  \    'javascript.jsx': 'node',
  \    'javascript': 'node',
  \    'vim': 'vim -N -u NONE -n -c "set nomore" -S'
  \ }
endif


function! CheckVersion()
  " warn user of incompatibility
  try
    if has('nvim')
      throw "neovim unsupported"
    elseif v:version > 800
      throw "invalid version"
    endif
  catch /.*neovim unsupported/
    echoerr "This plugin is not compatible with Neovim"
  catch /.*invalid version/
    echoerr "This plugin only supports vim >= 8.0"
  endtry
endfunction


function! RemovePreExistingBuffer(cmd)
  " deletes buffers containing previous script executions
  let name = "!" . a:cmd . " " . expand('%:p')
  for bufinfo in getbufinfo()
    if bufinfo.name =~# name && bufexists(bufinfo.bufnr)
      execute 'silent! bd! ' . bufinfo.bufnr
    endif
  endfor
endfunction


function! RunScriptInTerminal()
  " run current buffers code in a new terminal window
  write
  execute "term ++rows=" . g:runner_rowsize . " " . a:cmd  . " " . expand('%:p')
  wincmd p
endfunction


function! Runner()
  call CheckVersion()
  let filetype = &ft

  if filetype ==# ""
    return
  endif

  let cmd = get(g:runner_extensions, filetype, fftype)
  call RemovePreExistingBuffer(cmd)
  call RunScriptInTerminal(cmd)
endfunction


nnoremap <leader>1 :call Runner()<CR>
