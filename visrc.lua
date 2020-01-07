require('vis')
require('plugins/vis-filetype-settings')

settings = {
	python = {'set expandtab on', 'set tabwidth 4'}
}

vis.events.subscribe(vis.events.INIT, function()
	vis:command('set change-256colors on')
	vis:command('set theme zenburn')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set autoindent')
	vis:command('set show-tabs')
end)
