" Vim global plugin for remote collaborative editing
" Creation Date: 2020 Sep 3
" Maintainer:  jbyuki
" License:     This file is placed in the public domain 

let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_instant")
	finish
endif
let g:loaded_instant = 1

lua instant = require("instant")

function! StartSingleWrapper(...)
	if a:0 == 0 || a:0 > 2
		echoerr "ARGUMENTS: [host] [port (default: 80)]"
		return
	endif

	if a:0 == 1
		call execute('lua instant.Start(true, true, "' .. a:1 .. '")')
	else
		call execute('lua instant.Start(true, true, "' .. a:1 .. '", ' .. a:2 .. ')')
	endif
endfunction

function! JoinSingleWrapper(...)
	if a:0 == 0 || a:0 > 2
		echoerr "ARGUMENTS: [host] [port (default: 80)]"
		return
	endif

	if a:0 == 1
		call execute('lua instant.Start(false, true, "' .. a:1 .. '")')
	else
		call execute('lua instant.Start(false, true, "' .. a:1 .. '", ' .. a:2 .. ')')
	endif
endfunction

command! -nargs=* InstantStartSingle call StartSingleWrapper(<f-args>)

command! -nargs=* InstantJoinSingle call JoinSingleWrapper(<f-args>)

command! InstantStatus call execute('lua instant.Status()', "")

command! -nargs=* InstantStopSingle  call execute('lua instant.Stop()', "")
let &cpo = s:save_cpo
unlet s:save_cpo


