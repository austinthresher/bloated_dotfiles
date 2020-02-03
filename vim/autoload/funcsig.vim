if exists("g:funcsig_loaded")
    finish
endif
let g:funcsig_loaded = 1

let s:funcsig_string = ''

" Scans the current line from start to cursor position, tracking any
" identifiers followed by open parens it finds. When it reaches the
" cursor, the last unclosed paren attached to a name is the function
" whose arguments are being entered
func! s:get_surrounding_func()
    let l:col = getcurpos()[2]
    let l:str = strpart(getline("."), 0, l:col)
    let l:scope = 0 " Track the depth of our stack
    let l:name = "" " Accumulates the name-in-progress between parens
    let l:stack = [""] " Stack of names with parens we've seen 
    let l:space = 0 " Flag to clear l:name if a space was encountered
    for c in split(l:str, '\zs')
        let l:col -= 1
        if c ==# '('
            if l:space
                return ''
            endif
            while len(l:stack) <= l:scope
                let l:stack = l:stack + [""]
            endwhile
            let l:stack[l:scope] = l:name
            let l:scope += 1
            let l:name = ""
        elseif c ==# ')'
            if l:col > 0
                let l:scope -= 1
                if l:scope < 0
                    let l:scope = 0
                endif
                let l:name = l:stack[l:scope]
                if len(l:stack) > 1
                    let l:stack = l:stack[:-2]
                else
                    let l:stack = [""]
                endif
            endif
        elseif c =~ "[A-Za-z_0-9:]"
            if l:space
                let l:name = ""
                let l:space = 0
            endif
            let l:name = l:name.c
        elseif c =~ "[ \t]"
            let l:space = 1
            continue
        else
            let l:name = ""
        endif
    endfor
    return l:stack[-1]
endfunc

" Uses get_surrounding_func to either look up the tag or call :is
" TODO: strip excess whitespace, make sure to include closing paren for
" multiline definition
" TODO: try not to leave excess buffers open
func! s:find_under_cursor()
    let l:func = ""
    try
        let l:func = s:get_surrounding_func()
    catch
    endtry
    if len(l:func) > 0
        let l:tags = taglist(l:func)
        if !empty(l:tags)
            silent exe 'keepalt hide tag '.(l:tags[0].name)
            let l:line = getline(".")
            silent exe 'keepalt hide pop'
            return l:line
        endif
        try
            let l:sig = ""
            redir => l:sig
            silent exec "norm :is ".l:func."\<cr>"
            redir END
            return substitute(l:sig, '^\s*\(.\{-}\)\s*$', '\1', '')
        catch
        endtry
    endif
    return ''
endfunc

func! funcsig#update()
    if mode() =~ "[niR]"
        let l:win = winsaveview()
        let l:pos = getpos(".")
        let l:sig = s:find_under_cursor()
        call setpos('.', l:pos)
        call winrestview(l:win)
        let s:funcsig_string = l:sig
    else
        let s:funcsig_string = ''
    endif
endfunc

func! funcsig#get()
    return s:funcsig_string
endfunc

func! funcsig#enable()
    augroup FuncSig
        autocmd! * <buffer>
        autocmd CursorMoved <buffer> call funcsig#update()
        autocmd CursorMovedI <buffer> call funcsig#update()
    augroup END
endfunc
