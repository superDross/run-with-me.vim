" run-with-me.vim - Run With Me
" Author:      David Ross <https://github.com/superDross/>
" Version:     0.01


if exists('g:runner_rowsize') ==# 0
  let g:runner_rowsize = 15
endif


if exists('g:runner_cmds') ==# 0
  let g:runner_cmds = {
  \    'javascript.jsx': 'node',
  \    'javascript': 'node',
  \    'vim': 'vim -N -u NONE -n -c "set nomore" -S'
  \ }
endif


function! GetCommand(filetype)
  " constructs the full command to be run in the terminal
  let cmd = get(g:runner_cmds, a:filetype, a:filetype)
  return cmd . " " . expand('%:p')
endfunction


function! CheckVersion()
  " warn user of incompatibility
  try
    if has('nvim')
      throw "neovim unsupported"
    elseif v:version < 800
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
  let name = "!" . a:cmd
  for bufinfo in getbufinfo()
    if bufinfo.name =~# name && bufexists(bufinfo.bufnr)
      execute 'silent! bd! ' . bufinfo.bufnr
    endif
  endfor
endfunction


function! RunScriptInTerminal(cmd)
  " run current buffers code in a new terminal window
  write
  execute "term ++rows=" . g:runner_rowsize . " " . a:cmd
  wincmd p
endfunction


function! Runner()
  let filetype = &ft
  if filetype ==# ""
    return
  endif
  let cmd = GetCommand(filetype)
  call CheckVersion()
  call RemovePreExistingBuffer(cmd)
  call RunScriptInTerminal(cmd)
endfunction


command! RunCode :call Runner()
nnoremap <silent> <Plug>(run_code) :RunCode<Return>
