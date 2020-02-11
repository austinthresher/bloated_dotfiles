if exists('g:autoformat_loaded')
    finish
endif
let g:autoformat_loaded = 1

" Expects cmd to echo the formatted result to stdout if succesful,
" exit with nonzero if format was unsuccessful.
" Do not use modify-in-place flags. Only works if contents are
" written to disk.
func autoformat#run(cmd)
    let l:win = winsaveview()
    let l:pos = getpos(".")
    if b:autoformat_path
        call system(a:cmd.' '.shellescape(expand('%')).' &> /dev/null')
        if v:shell_error
            silent !echo -ne '\e[2K\rautoformat failed'
            return
        endif
        silent exe '%!cat &> /dev/null && '.a:cmd.' '.shellescape(expand('%'))
    else
        silent exe '%!'.a:cmd
    endif
    if v:shell_error == 0
        silent !echo -ne '\e[2K\rautoformatted'
    else
        silent !echo -ne '\e[2K\rautoformat failed'
    endif
    call setpos('.', l:pos)
    call winrestview(l:win)
endfunc

" Sets the command for autoformatting the current buffer and triggers it
" whenever the buffer is written to disk
func autoformat#set_augroup(cmd)
    let b:autoformat_cmd = a:cmd
    augroup AutoFormat
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> call autoformat#run(b:autoformat_cmd)
    augroup END
endfunc

" Pass the filename as an argument
func autoformat#enable_path(cmd)
    let b:autoformat_path = 1
    call autoformat#set_augroup(a:cmd)
endfunc

" Pipe the file contents on stdin
func autoformat#enable_pipe(cmd)
    let b:autoformat_path = 0
    call autoformat#set_augroup(a:cmd)
endfunc

