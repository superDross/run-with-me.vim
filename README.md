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

![runcode](https://user-images.githubusercontent.com/16519378/199552946-f8362b1d-940d-4587-8f4f-36779f9ebd90.gif)


### Visual Execution

Execute `:RunSelectedCode` to run code selected in visual mode.

Alternatively, you can map the command to a key. Place the below snippet into your vimrc to map the command to Leader 9:

```vim
nmap <leader>9 :RunSelectedCode<CR>
" run in vertical terminal window instead
nmap <leader>9 :RunSelectedCodeVert<CR>
```

![runselectedcode](https://user-images.githubusercontent.com/16519378/199552991-10a08db6-d428-4aa4-99e7-87af4218dad1.gif)


### Tests Execution

Execute `:RunTests` to run your testing command in the current directory.

Testing command to run will be dependant upon the current windows filetype. Setting `g:default_testing_cmd` will run the same testing command regardless of filetype.

Mappings can be set like so:

```vim
nmap <leader>1 :RunTests<CR>
" run in vertical terminal window instead
nmap <leader>1 :RunTestsVert<CR>
```

![runtests](https://user-images.githubusercontent.com/16519378/199553067-12de03fe-f6e2-4901-8e7b-e73a1f3245b3.gif)


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

![runmoduletests](https://user-images.githubusercontent.com/16519378/199553163-6a90ead5-3d5c-4f43-bfa1-add7c87c8457.gif)


Execute `:RunNearestTest` to run *only* the test nearest above the cursor.

Mappings can be set like so:

```vim

nmap <leader>1 :RunNearestTest<CR>
" run in vertical terminal window instead
nmap <leader>1 :RunNearestTestVert<CR>
```

![runnearesttest](https://user-images.githubusercontent.com/16519378/199553227-20816336-d8b6-4473-802c-34fa1ecc6388.gif)


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
