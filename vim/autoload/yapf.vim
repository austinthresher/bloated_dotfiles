if exists('g:yapf_loaded')
    finish
endif
let g:yapf_loaded = 1

func yapf#run()
    try
        exe "%!python3 -m yapf"
    catch
        echo 'failed to run yapf'
    endtry
endfunc

func yapf#enable_on_save()
    augroup AutoIndent
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> call yapf#run()
    augroup END
endfunc
