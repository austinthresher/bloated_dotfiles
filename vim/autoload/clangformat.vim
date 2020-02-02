" Simple wrapper around the Python script included with clang-format
" Last Change: 2020 Feb 1
" Author: Austin Thresher
" License: Same as vim

if exists("g:clang_format_loaded")
    finish
endif
let g:clang_format_loaded = 1

if exists("g:clang_format_py") == 0
	let g:clang_format_py = '/usr/share/clang/clang-format-9/clang-format.py'
endif

if exists("g:clang_format_fallback_style") == 0
	let g:clang_format_fallback_style = 'WebKit'
endif

func clangformat#run()
    if has("python3") && filereadable(g:clang_format_py)
        let l:lines = 'all'
        let l:formatdiff = 1
        exe 'py3f '.g:clang_format_py
    endif
endfunc

func clangformat#enable_on_save()
    augroup AutoClangFormat
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> call clangformat#run()
    augroup END
endfunc
