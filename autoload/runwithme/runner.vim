" Runner.vim
"
" Module containing script runner logic


function! runwithme#runner#GetScriptCommand() abort
  " constructs the full command to be run in the terminal
  let cmd = get(g:runner_cmds, &filetype, &filetype)
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
  " a:cmd (str): command to run in the terminal
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  write
  let termcmd = runwithme#runner#GetTerminalCommand(a:vert)
  execute termcmd . ' ' . a:cmd
  normal! G
  wincmd p
endfunction


function! runwithme#runner#Runner(cmd, vert) abort
  " runs a given command in a terminal
  " cmd: command to run in the terminal
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  call runwithme#utils#CheckVersion()
  call runwithme#utils#RemovePreExistingBuffer(a:cmd)
  call runwithme#runner#RunCommandInTerminal(a:cmd, a:vert)
endfunction


function! runwithme#runner#RunScript(vert) abort
  " executes current windows code in a terminal
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  if &filetype ==# ''
    return
  endif
  let cmd = runwithme#runner#GetScriptCommand()
  call runwithme#runner#Runner(cmd, a:vert)
endfunction


function! runwithme#runner#RunCode(code, vert) abort
  " run some code parsed as a string
  " a:code (str): code to directly run
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  let filename = '/tmp/' . fnamemodify(bufname('%'), ':t')
  call writefile(a:code, filename)
  let cmd = get(g:runner_cmds, &filetype, &filetype)
  call runwithme#runner#Runner(cmd . ' ' . filename, a:vert)
endfunction


function! runwithme#runner#RunSelectedCode(vert) abort
  " executes current or previous visually selected code in a terminal
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  let selectedcode = getline(getpos("'<")[1], getpos("'>")[1])
  call runwithme#runner#RunCode(selectedcode, a:vert)
endfunction


function! runwithme#runner#RunCodeToCursor(vert) abort
  " executes code from first line to the current cursor line
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  call runwithme#runner#RunCode(getline(0, line('.')), a:vert)
endfunction
