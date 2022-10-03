" Tests.vim
"
" Module containing all commands associated with test execution


function! runwithme#tests#GetTestingCommand(filetype) abort
  " returns testing command in string format
  if exists('g:default_testing_cmd') ==# 1
    return g:default_testing_cmd
  else
    return get(g:testing_cmds, a:filetype)
  endif
endfunction


function! runwithme#tests#RunTestSuite(vert) abort
  " executes testing command in a terminal
  let filetype = &filetype
  if filetype ==# ''
    return
  endif
  let cmd = runwithme#tests#GetTestingCommand(filetype)
  call runwithme#runner#Runner(cmd, a:vert)
endfunction


function! runwithme#tests#GetNearestPythonTestingCommand(func_name) abort
  " run nearest python test above the cursor
  let full_test_path = expand('%:.') . '::' . a:func_name
  return runwithme#tests#GetTestingCommand('python') . '"' . full_test_path . '"'
endfunction


function! runwithme#tests#GetNearestTestingCommand(filetype) abort
  " run test nearest that is above the cursor
  let func_name = runwithme#utils#GetNearestFuncName()
  if tolower(func_name) !~# '^test'
    throw 'Test ' . func_name . ' does not begin with test'
  endif
  " TODO: consider a different approach to just filetype conditionals
  if a:filetype ==# 'python'
    return runwithme#tests#GetNearestPythonTestingCommand(func_name)
  else
    throw 'Executing nearest test only works with python'
  endif
endfunction


function! runwithme#tests#RunNearestTest(vert) abort
  " run test nearest above the cursor
  let filetype = &filetype
  if filetype ==# ''
    return
  endif
  let cmd = runwithme#tests#GetNearestTestingCommand(filetype)
  call runwithme#runner#Runner(cmd, a:vert)
endfunction
