" Clear all keymaps for all modes except printable chars in insert mode.
" This isn't exhaustive, but seems to cover everything I've tried
let keys = [
	\ '`', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '-', '=',
	\ '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+',
	\ 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', '['. ']', '\\',
	\ 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '{', '}', '\|',
	\ 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', "'",
	\ 'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ':', '"',
	\ 'z', 'x', 'c', 'v', 'b', 'n', 'm', '.', ',', '/',
	\ 'Z', 'X', 'C', 'V', 'B', 'N', 'M', '<', '>', '?'
	\ ]

let prefixes = [
	\ '', 'g', '<c-w>', 'z', '<leader>'
	\ ]

let n = "<nop>"

for k in keys
	for p in prefixes
		execute "noremap ".p.k." \<nop>" 
		execute "noremap ".p."<c-".k."> \<nop>"
		execute "noremap ".p."<m-".k."> \<nop>"
		execute "inoremap ".p."<c-".k."> \<nop>"
		execute "inoremap ".p."<m-".k."> \<nop>"
	endfor
endfor

let special_keys = [
	\ 'Esc', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7',
	\ 'F8', 'F9', 'F10', 'F11', 'F12', 'insert', 'del',
	\ 'home', 'end', 'pageup', 'pagedown', 'enter', 'tab',
	\ 'up', 'down', 'left', 'right', 'nl'
	\ ]

for k in special_keys
	for p in prefixes
		execute "noremap ".p."<".k."> \<nop>"
		execute "noremap ".p."<c-".k."> \<nop>"
		execute "noremap ".p."<m-".k."> \<nop>"
		execute "noremap ".p."<s-".k."> \<nop>"
		execute "inoremap ".p."<c-".k."> \<nop>"
		execute "inoremap ".p."<m-".k."> \<nop>"
		execute "inoremap ".p."<s-".k."> \<nop>"
	endfor
endfor

" Congrats- now you can't do anything!
