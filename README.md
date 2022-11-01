# Run With Me

A simple script runner plugin with a pompous name.

Runs the current buffers code or tests in a separate terminal window.

![](https://user-images.githubusercontent.com/16519378/186270965-38799bd8-86b4-442a-a6ab-65b1006f8f3f.gif)


## Installation

Supports both vim >= version 8.2 and neovim.

In your vimrc file;

```vim
Plug 'superDross/run-with-me.vim'
```


## Usage

### Script Execution

Execute `:RunCode` to run your current windows code in a terminal.

Alternatively, you can map the command to a key. Place the below snippet into your vimrc to map the command to Leader 9:

```vim
nmap <leader>9 :RunCode<CR>
" run in vertical terminal window instead
nmap <leader>9 :RunCodeVert<CR>
```

### Visual Execution

Execute `:RunSelectedCode` to run code selected in visual mode.

Alternatively, you can map the command to a key. Place the below snippet into your vimrc to map the command to Leader 9:

```vim
nmap <leader>9 :RunSelectedCode<CR>
" run in vertical terminal window instead
nmap <leader>9 :RunSelectedCodeVert<CR>
```


### Tests Execution

Execute `:RunTests` to run your testing command in the current directory.

Testing command to run will be dependant upon the current windows filetype. Setting `g:default_testing_cmd` will run the same testing command regardless of filetype.

Mappings can be set like so:

```vim
nmap <leader>1 :RunTests<CR>
" run in vertical terminal window instead
nmap <leader>1 :RunTestsVert<CR>
```

<!-- https://github.com/community/community/discussions/16925 -->
<!-- > **Note** -->
<!-- > 
<!-- > This is a note -->

> **Warning**
>
> The following test commands only work with _Python_ tests.

Execute `:RunModuleTests` to run *only* the tests in the current file.

Mappings can be set like so:

```vim
nmap <leader>1 :RunModuleTest<CR>
" run in vertical terminal window instead
nmap <leader>1 :RunModuleTestVert<CR>
```

Execute `:RunNearestTest` to run *only* the test nearest above the cursor.

Mappings can be set like so:

```vim

nmap <leader>1 :RunNearestTest<CR>
" run in vertical terminal window instead
nmap <leader>1 :RunNearestTestVert<CR>
```

## Configuration

Change row size of the horizontal terminal output:

```vim
let g:runner_rowsize = 15
```

Overwrite base commands for a give language e.g. use python3.9 for all python script executions:

```vim
let g:runner_cmds['python'] = 'python3.9'
```

Overwrite base testing command for a given language e.g. use nosetests instead of pytest for python:

```vim
let g:testing_cmds['python'] = 'nosetests'
```

The below config will run the given test command regardless of filetype:

```vim
let g:default_testing_cmd = 'make test'
```
