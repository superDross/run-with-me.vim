# Run With Me

A simple script runner plugin with a pompous name.

Runs the current buffers code or tests in a separate terminal window.

![](docs/run-with-me.gif)


## Installation

Supports both vim >= version 8.2 and neovim.

In your vimrc file;

```vim
Plug 'superDross/run-with-me.vim'
```


## Execution

### Script Execution

Execute `:RunCode` to run your current windows code in a terminal.

Alternatively, you can map the command to a key. Place the below snippet into your vimrc to map the command to Leader 9:

```vim
nmap <silent> <leader>9 <Plug>(run_code)
" run in vertical terminal window instead
nmap <silent> <leader>9 <Plug>(run_code_vert)
```

### Tests Execution

Execute `:RunTests` to run your testing command in the current directory.

Testing command to run will be dependant upon the current windows filetype. Setting `g:default_testing_cmd` will run the same testing command regardless of filetype.

Mappings can be set like so:

```vim
nmap <leader>1 <Plug>(run_tests)
" run in vertical terminal window instead
nmap <leader>1 <Plug>(run_tests_vert)
```


## Configuration

Change row size of the horizontal terminal output:

```vim
let g:runner_rowsize = 15
```

Use a different command other than the filetype:

```vim
" e.g. if filetype is javascript run script with node command
let g:runner_cmds = {
\    'javascript.jsx': 'node',
\    'javascript': 'node',
\    'vim': 'vim -N -u NONE -n -c "set nomore" -S'
\ }
```

Configure testing command for each filetype:

```vim
let g:testing_cmds = {
\     'python': 'pytest',
\ }
```

The below config will run the given test command regardless of filetype:

```vim
let g:default_testing_cmd = "make test"
```
