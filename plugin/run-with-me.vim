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
  \    'vim': 'vim -N -u NONE -n -c "set nomore" -S',
  \    'tex': 'pdflatex'
  \ }
endif


if exists('g:testing_cmds') ==# 0
  let g:testing_cmds = {
  \     'python': 'pytest',
  \ }
endif


function! GetTestingCommand(filetype)
  " returns testing command in string format
  if exists('g:default_testing_cmd') ==# 1
    return g:default_testing_cmd
  else
    return get(g:testing_cmds, a:filetype)
  endif
endfunction


function! GetScriptCommand(filetype)
  " constructs the full command to be run in the terminal
  let cmd = get(g:runner_cmds, a:filetype, a:filetype)
  return cmd . " " . expand('%:p')
endfunction


function! GetTerminalCommand(vert)
  " returns terminal command string in horizontal or vertical mode
  " a:vert (bool) = whether to run in vertical window
  if a:vert ==# 0
    return "term ++rows=" . g:runner_rowsize
  else
    return "vert term "
  endif
endfunction


function! CheckVersion()
  " warn user of incompatibility
  try
    if has('nvim')
      throw "neovim unsupported"
    elseif v:version < 802
      throw "invalid version"
    endif
  catch /.*neovim unsupported/
    echoerr "This plugin is not compatible with Neovim"
  catch /.*invalid version/
    " use of default args supported in 8.1.13 or above
    echoerr "This plugin only supports vim >= 8.2"
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


function! RunCommandInTerminal(cmd, vert)
  " run the given command in a new terminal window
  write
  let termcmd = GetTerminalCommand(a:vert)
  execute termcmd . " " . a:cmd
  wincmd p
endfunction


function! Runner(cmd, vert)
  " runs a given command in a terminal
  call CheckVersion()
  call RemovePreExistingBuffer(a:cmd)
  call RunCommandInTerminal(a:cmd, a:vert)
endfunction


function! RunScript(vert = 0)
  " executes current windows code in a terminal
  let filetype = &ft
  if filetype ==# ""
    return
  endif
  let cmd = GetScriptCommand(filetype)
  call Runner(cmd, a:vert)
endfunction


function! RunTestSuite(vert = 0)
  " executes testing command in a terminal
  let filetype = &ft
  if filetype ==# ""
    return
  endif
  let cmd = GetTestingCommand(filetype)
  call Runner(cmd, a:vert)
endfunction


command! -nargs=* RunCode :call RunScript(<args>)
nnoremap <silent> <Plug>(run_code) :RunCode 0<Return>
nnoremap <silent> <Plug>(run_code_vert) :RunCode 1<Return>

command! -nargs=* RunTests :call RunTestSuite(<args>)
nnoremap <silent> <Plug>(run_tests) :RunTests 0<Return>
nnoremap <silent> <Plug>(run_tests_vert) :RunTests 1<Return>
