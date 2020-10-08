function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let curline = a:lnum + 1

    while curline <= numlines
        if getline(curline) =~? '\v\S'
            return curline
        endif
        let curline += 1
    endwhile

    " If there is no next nonblank line, return the starting line
    return a:lnum
endfunction

function! FilterFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let current_indent = IndentLevel(a:lnum)
    let next_non_blank = NextNonBlankLine(a:lnum)
    if next_non_blank > current_indent
        let next_indent = IndentLevel(next_non_blank)

        if next_indent <= current_indent
            return current_indent
        endif
        return '>' . next_indent
    endif

    return '-1'
endfunction

setlocal foldmethod=expr
setlocal foldexpr=FilterFold(v:lnum)
