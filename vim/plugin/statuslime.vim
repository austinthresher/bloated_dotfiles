augroup StatusLime
    au!
    au WinEnter,BufEnter * call statuslime#focused()
    au WinLeave,BufLeave * call statuslime#unfocused()
augroup END
