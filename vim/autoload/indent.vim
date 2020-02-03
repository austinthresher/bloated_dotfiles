if exists('g:indent_loaded')
    finish
endif
let g:indent_loaded = 1

func indent#run()
    if executable('indent')
        norm! "%!indent -kr"
    endif
endfunc

func indent#enable_on_save()
    augroup AutoIndent
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> call indent#run()
    augroup END
endfunc

