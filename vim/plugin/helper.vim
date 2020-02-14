" Copyright (c) 2020 Austin Thresher
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" helper.vim provides a quick and easy way to see what plugins have
" documentation available. The command :Helper has tab completion for
" any plugin's help files, and :HelperToggle shows a menu that allows
" selecting the name of a plugin interactively to view its help file.

" To use helper.vim, replace the calls to vim-plug in your vimrc with
" the wrapper functions provided. Check autoload/helper.vim for info.

if exists("g:loaded_helper") | finish | endif
let g:loaded_helper = v:true

func! HelperComplete(ArgLead, CmdLine, CursorPos)
    return helper#found()
endfunc

command! HelperToggle call helper#toggle()
command! -nargs=1 -complete=customlist,HelperComplete Helper :h <args>
noremap <Plug>(helper-toggle) :HelperToggle<cr>
