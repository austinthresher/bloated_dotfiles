if exists("g:clang_format_py") == 0
	let g:clang_format_py = '/usr/share/clang/clang-format-9/clang-format.py'
endif
if exists("g:clang_format_fallback_style") == 0
	let g:clang_format_fallback_style = 'WebKit'
endif
if filereadable(g:clang_format_py)
	function! s:run_clang_format()
		let l:lines="all"
		let l:formatdiff = 1
		exe 'py3f '.g:clang_format_py
	endfunction
	augroup AutoClangFormat
		autocmd! * <buffer>
		autocmd BufWritePre <buffer> call s:run_clang_format()
	augroup END
else
	echo "clang-format not found"
endif
