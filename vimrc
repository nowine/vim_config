"Normal functions
set nocompatible
syntax on
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
filetype plugin indent on
filetype plugin on
set nowrap
set hlsearch
set incsearch
set backspace=indent,eol,start whichwrap+=<,>,[,] "Allow backspace
execute pathogen#infect()

"Enable Pydiction
let g:pydiction_location='~/.vim/tools/complete-dict'
let g:pydiction_menu_height=20

"Map F2 for NerdTree
nnoremap <F2> : NERDTreeToggle<CR>

"Set Color Scheme to Molokai
colorschem Solarized 
set background=dark
"colorschem molokai
"let g:molokai_original = 1

"Setting Ctags and Cscope command
nmap <C-@>s : cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g : cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c : cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t : cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e : cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f : cs find f <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>i : cs find i ^<C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>d : cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nnoremap <F12> : call Do_CsTag()<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        let tagsdeleted=delete("./"."tags")
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        let csfilesdeleted=delete("./"."cscope.files")
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        let csoutdeleted=delete("./"."cscope.out")
        if (csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        silent! execute "!ctags -R --c-types=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope"))
        silent! execute "!find . -name '*.py' -o -name '*.js' -o -name '*.css' > cscope.files"
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

nnoremap <F3> : silent! Tlist<CR>
let Tlist_Ctags_Cmd='ctags'
let Tlist_Use_Right_Window=0
let Tlist_Show_One_File=0
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=0
let Tlist_Inc_Winwidth=0


