if exists('g:autoformat_loaded')
    finish
endif
let g:autoformat_loaded = 1

" Expects cmd to echo the formatted result to stdout if succesful,
" exit with nonzero if format was unsuccessful.
" Do not use modify-in-place flags
func autoformat#run(cmd)
    let l:win = winsaveview()
    let l:pos = getpos(".")
    call system(a:cmd.' '.shellescape(expand('%')).' &> /dev/null')
    if v:shell_error
        silent !echo -ne '\e[2K\rautoformat failed'
        return
    endif
    silent exe '%!'.a:cmd.' '.shellescape(expand('%'))
    if v:shell_error == 0
        silent !echo -ne '\e[2K\rautoformatted'
    else
        silent !echo -ne '\e[2K\rautoformat failed when success was expected'
    endif
    call setpos('.', l:pos)
    call winrestview(l:win)
endfunc

" Sets the command for autoformatting the current buffer and triggers it
" whenever the buffer is written to disk
func autoformat#enable(cmd)
    let b:autoformat_cmd = a:cmd
    augroup AutoFormat
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> call autoformat#run(b:autoformat_cmd)
    augroup END
endfunc
