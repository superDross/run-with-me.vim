" Runner.vim
"
" Module containing script runner logic


function! runwithme#runner#GetScriptCommand(filetype) abort
  " constructs the full command to be run in the terminal
  let cmd = get(g:runner_cmds, a:filetype, a:filetype)
  return cmd . ' ' . expand('%:p')
endfunction


function! runwithme#runner#GetTerminalCommand(vert) abort
  " returns terminal command string in horizontal or vertical mode
  " a:vert (bool) = whether to run in vertical window
  if a:vert ==# 0
    let nv_cmd = 'sp | resize ' . g:runner_rowsize . ' | term '
    let v_cmd = 'term ++rows=' . g:runner_rowsize
    return has('nvim') == 1 ? nv_cmd : v_cmd
  else
    return has('nvim') == 1 ? 'vs | term ' : 'vert term '
  endif
endfunction


function! runwithme#runner#RunCommandInTerminal(cmd, vert) abort
  " run the given command in a new terminal window
  write
  let termcmd = runwithme#runner#GetTerminalCommand(a:vert)
  execute termcmd . ' ' . a:cmd
  normal G
  wincmd p
endfunction


function! runwithme#runner#Runner(cmd, vert) abort
  " runs a given command in a terminal
  call runwithme#utils#CheckVersion()
  call runwithme#utils#RemovePreExistingBuffer(a:cmd)
  call runwithme#runner#RunCommandInTerminal(a:cmd, a:vert)
endfunction


function! runwithme#runner#RunScript(vert) abort
  " executes current windows code in a terminal
  let filetype = &filetype
  if filetype ==# ''
    return
  endif
  let cmd = runwithme#runner#GetScriptCommand(filetype)
  call runwithme#runner#Runner(cmd, a:vert)
endfunction
