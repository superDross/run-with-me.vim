" Tests.vim
"
" Module containing all commands associated with test execution


function! runwithme#tests#GetTestingCommand() abort
  " returns testing command in string format
  if &filetype ==# ''
    return
  endif
  if exists('g:default_testing_cmd') ==# 1
    return g:default_testing_cmd . ' '
  else
    return get(g:testing_cmds, &filetype) . ' '
  endif
endfunction


function! runwithme#tests#GetPythonTestingCommand(nearest) abort
  " construct command to run the nearest python test above the cursor or all
  " tests in the current file
  " a:nearest (bool): 1 to only run the nearest file, 0 to run all tests in the file
  let full_test_path = expand('%:.')
  if a:nearest
    let full_test_path = full_test_path . '::' . runwithme#utils#GetNearestFuncName()
  endif
  return runwithme#tests#GetTestingCommand() . '"' . full_test_path . '"'
endfunction


function! runwithme#tests#GetNearestTestingCommand(nearest) abort
  " construct command to run the nearest test above the cursor or all
  " tests in the current file
  " a:nearest (bool): 1 to only run the nearest file, 0 to run all tests in the file
  if &filetype ==# 'python'
    return runwithme#tests#GetPythonTestingCommand(a:nearest)
  else
    throw 'Executing nearest test only works with python'
  endif
endfunction


function! runwithme#tests#RunNearestTest(vert) abort
  " run test nearest above the cursor
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  let cmd = runwithme#tests#GetNearestTestingCommand(1)
  call runwithme#runner#Runner(cmd, a:vert)
endfunction


function! runwithme#tests#RunModuleTests(vert) abort
  " run all tests in the current file
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  let cmd = runwithme#tests#GetNearestTestingCommand(0)
  call runwithme#runner#Runner(cmd, a:vert)
endfunction


function! runwithme#tests#RunTestSuite(vert) abort
  " executes entire testing suite
  " a:vert (bool): 1 run in vertical terminal, 0 run in horizontal terminal
  let cmd = runwithme#tests#GetTestingCommand()
  call runwithme#runner#Runner(cmd, a:vert)
endfunction
