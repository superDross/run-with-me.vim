# Run With Me

A simple script runner plugin with a pompous name.

Runs the current buffers code in a terminal beneath your current window.


## Configuration

All below examples are the default values.

Change row size of the terminal output:

```vim
let g:runner_rowsize = 15
```

Use a different command to the filetype:

```vim
" e.g. if filetype is javascript run script with node command
let g:runner_extensions = {
\    'javascript.jsx': 'node',
\    'javascript': 'node',
\    'vim': 'vim -N -u NONE -n -c "set nomore" -S'
\ }
```
