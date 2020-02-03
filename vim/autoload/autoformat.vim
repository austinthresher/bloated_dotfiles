if exists('g:autoformat_loaded')
    finish
endif
let g:autoformat_loaded = 1

" Expects cmd to echo the formatted result to stdout if succesful,
" exit with nonzero if format was unsuccessful.
" Do not use modify-in-place flags
func autoformat#run(cmd)
    call system(a:cmd.' '.shellescape(expand('%')).' &> /dev/null')
    if v:shell_error
        silent !echo -n ' *autoformat failed*'
        return
    endif
    silent exe '%!'.a:cmd
    if v:shell_error == 0
        silent !echo -n ' *autoformatted*'
    else
        silent !echo -n ' *autoformat failed when success was expected*'
    endif
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
