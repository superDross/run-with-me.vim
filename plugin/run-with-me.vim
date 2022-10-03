" run-with-me.vim - Run With Me
" Author:      David Ross <https://github.com/superDross/>


if exists('g:runner_rowsize') ==# 0
  let g:runner_rowsize = 15
endif


if exists('g:test_args') ==# 0
  let g:test_args = ''
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


command! -nargs=* RunCode :call runwithme#runner#RunScript(0)
command! -nargs=* RunCodeVert :call runwithme#runner#RunScript(1)
command! -nargs=* RunTests :call runwithme#tests#RunTestSuite(0)
command! -nargs=* RunTestsVert :call runwithme#tests#RunTestSuite(1)
command! -nargs=* RunNearestTest :call runwithme#tests#RunNearestTest(0)
command! -nargs=* RunNearestTestVert :call runwithme#tests#RunNearestTest(1)
