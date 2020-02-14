if exists("g:helper_loaded") | finish | endif

let g:helper_loaded = v:true

" Requires junegunn/vim-plug and skywind3000/quickmenu.vim
" Automatically includes quickmenu, so no need to include
" it in your vimrc.

func! helper#begin()
    if exists("g:helper_plug_path") == v:false
        let g:helper_plug_path = has('nvim') ?
                    \ $HOME.'/.config/nvim/plugged' :
                    \ $HOME.'/.vim/plugged'
    endif
    try
        call plug#begin(g:helper_plug_path)
    catch
        echoerr "helper#begin failed: vim-plug is missing or broken"
    endtry
    let s:plugin_list = []
endfunc

func! helper#plug(repo)
    try
        call plug#(a:repo)
        let s:plugin_list = s:plugin_list + [a:repo]
    catch
        echoerr 'helper#plug failed for plugin '.a:repo
    endtry
endfunc

func! s:populate()
    " quickmenu supports multiple menus with unique ids, pick one if it
    " hasn't already been set
    if exists("g:helper_menu_id") == v:false
        let g:helper_menu_id = 42
    endif
    let g:quickmenu_options = "H"
    try
        " Populate quickmenu with installed plugins with helpfiles
        call quickmenu#current(g:helper_menu_id)
        call quickmenu#reset()
        call quickmenu#header('plugin help')
        for plug in s:plugin_list
            " Grab the plugin's directory name from author/repo pairing
            let l:dir = split(plug, '/')[1]
            " Check if a directory named doc exists in the plugin
            let l:doc = g:helper_plug_path.'/'.l:dir.'/doc'
            if isdirectory(l:doc)
                " Get the plugin's name without 'vim' as a prefix or suffix
                let l:short = substitute(
                    \ substitute(l:dir, 'vim-', '', 'g'),
                    \ '.vim', '', 'g')
                " Help files are usually at one of these filenames
                let l:potentials = [
                    \ l:doc.'/'.l:short.'.txt',
                    \ l:doc.'/'.l:dir.'.txt'
                    \ ]
                let l:globbed = glob(l:doc.'/*.txt')
                if type(l:globbed) == type([])
                    let l:potentials = l:potentials + l:globbed
                else
                    let l:potentials = l:potentials + [string(l:globbed)]
                endif
                " Add a menu entry if we find a help file
                for txt in l:potentials
                    if filereadable(txt)
                        " It appears that vim uses the name listed at the top
                        " of the help file to determine the name of that help
                        " section
                        let l:head = split(system('head -n 1 '.txt), '*')[0]
                        call quickmenu#append(l:short, 'h '.l:head, '')
                        break
                    endif
                endfor
            endif
        endfor
    catch
        echom 'helper#populate was unsuccessful'
    endtry
endfunc

func! helper#toggle()
    call quickmenu#toggle(g:helper_menu_id)
endfunc

func! helper#end()
    call plug#('skywind3000/quickmenu.vim')
    call plug#end() 
    call s:populate() 
endfunc

