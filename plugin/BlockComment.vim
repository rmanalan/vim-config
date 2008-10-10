" BlockComment.vim
" Author: Chris Russell
" Version: 1.1
" License: GPL v2.0 
" 
" Description:
" This script defineds functions and key mappings to block comment code.
" 
" Help: 
" In brief, use '.c' to comment and '.C' to uncomment.
" 
" Both commenting and uncommenting can be run on N lines at a time by 
" using a number before the command.  They both support visual mode and 
" ranges.
" 
" This script will not comment lines with an indent level less that the 
" initial line of the comment to preserve the control structure of code.
"
" Installation:
" Simply drop this file into your plugin directory.
" 
" Changelog:
" 2002-11-08 v1.1
" 	Convert to Unix eol
" 2002-11-05 v1.0
" 	Initial release
" 
" TODO:
" Add more file types
" 


"--------------------------------------------------
" Avoid multiple sourcing
"-------------------------------------------------- 
if exists( "loaded_block_comment" )
	finish
endif
let loaded_block_comment = 1


"--------------------------------------------------
" Key mappings
"-------------------------------------------------- 
noremap <silent> .c :call Comment()<CR>
noremap <silent> .C :call UnComment()<CR>


"--------------------------------------------------
" Set comment characters by filetype
"-------------------------------------------------- 
function! CommentStr()
	let s:comment_pad = '--------------------------------------------------'
	if &ft == "vim"
		let s:comment_strt = '"'
		let s:comment_mid0 = '" '
		let s:comment_mid1 = '"'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "c" || &ft == "css"
		let s:comment_strt = '/*'
		let s:comment_mid0 = '* '
		let s:comment_mid1 = '*'
		let s:comment_stop = '*/'
		let s:comment_bkup = 1
		let s:comment_strtbak = '/ *'
		let s:comment_stopbak = '* /'
	elseif &ft == "cpp" || &ft == "java" || &ft == "javascript" || &ft == "php"
		let s:comment_strt = '//'
		let s:comment_mid0 = '// '
		let s:comment_mid1 = '//'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "asm" || &ft == "lisp" || &ft == "scheme"
		let s:comment_strt = ';'
		let s:comment_mid0 = '; '
		let s:comment_mid1 = ';'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "vb"
		let s:comment_strt = '\''
		let s:comment_mid0 = '\' '
		let s:comment_mid1 = '\''
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	elseif &ft == "html" || &ft == "xml" || &ft == "entity"
		let s:comment_strt = '<!--'
		let s:comment_mid0 = '! '
		let s:comment_mid1 = '!'
		let s:comment_stop = '-->'
		let s:comment_bkup = 1
		let s:comment_strtbak = '< !--'
		let s:comment_stopbak = '-- >'
	else
		let s:comment_strt = '#'
		let s:comment_mid0 = '# '
		let s:comment_mid1 = '#'
		let s:comment_stop = ' '
		let s:comment_bkup = 0
	endif
endfunction

"--------------------------------------------------
" Comment a block of code
"-------------------------------------------------- 
function! Comment() range
	" range variables
	let l:firstln = a:firstline
	let l:lastln = a:lastline
	" get comment chars
	call CommentStr()
	" get tab indent level
	let l:indent = indent( l:firstln ) / &tabstop
	" loop to get padding str
	let l:pad = ""
	let l:i = 0
	while l:i < l:indent
		let l:pad = l:pad . "\t"
		let l:i = l:i + 1
	endwhile
	" loop for each line
	let l:block = 0
	let l:midline = l:firstln
	while l:midline <= l:lastln
		" get line
		let l:line = getline( l:midline )
		" check if padding matches
		if strpart( l:line, 0, l:indent ) == l:pad
			" start comment block
			if l:block == 0
				call append( l:midline - 1, l:pad . s:comment_strt . s:comment_pad )
				let l:midline = l:midline + 1
				let l:lastln = l:lastln + 1
				let l:block = 1
			endif
			" append comment between indent and code
			let l:line = strpart( l:line, l:indent )
			" handle comments within comments
			if s:comment_bkup == 1
				let l:line = substitute( l:line, escape( s:comment_strt, '\*^$.~[]' ), s:comment_strtbak, "g" )
				let l:line = substitute( l:line, escape( s:comment_stop, '\*^$.~[]' ), s:comment_stopbak, "g" )
			endif
			call setline( l:midline, l:pad . s:comment_mid0 . l:line )
		" else end block
		elseif l:block == 1
			call append( l:midline - 1, l:pad . s:comment_mid1 . s:comment_pad . s:comment_stop )
			let l:midline = l:midline + 1
			let l:lastln = l:lastln + 1
			let l:block = 0
		endif
		let l:midline = l:midline + 1
	endwhile
	" end block
	if l:block == 1
		call append( l:lastln, l:pad . s:comment_mid1 . s:comment_pad . s:comment_stop )
	endif
	" return to first line of comment
	execute l:firstln
endfunction

"--------------------------------------------------
" Uncomment a block of code
"-------------------------------------------------- 
function! UnComment() range
	" range variables
	let l:firstln = a:firstline
	let l:lastln = a:lastline
	" get comment chars
	call CommentStr()
	" get length of comment string
	let l:clen = strlen( s:comment_mid0 )
	" loop for each line
	let l:midline = l:firstln
	while l:midline <= l:lastln
		" get indent level - process indent for each line instead of by block
		let l:indent = indent( l:midline ) / &tabstop
		let l:line = getline( l:midline )
		" begin comment block line - delete line
		if strpart( l:line, l:indent ) == s:comment_strt . s:comment_pad
			execute l:midline . "d"
			let l:midline = l:midline - 1
			let l:lastln = l:lastln - 1 
		" end comment block line - delete line
		elseif strpart( l:line, l:indent ) == s:comment_mid1 . s:comment_pad . s:comment_stop
			execute l:midline . "d"
			let l:midline = l:midline - 1
			let l:lastln = l:lastln - 1
		" commented code line - remove comment
		elseif strpart( l:line, l:indent, l:clen ) == s:comment_mid0
			let l:pad = strpart( l:line, 0, l:indent )
			let l:line = strpart( l:line, l:indent + l:clen )
			" handle comments within comments
			if s:comment_bkup == 1
				let l:line = substitute( l:line, escape( s:comment_strtbak, '\*^$.~[]' ), s:comment_strt, "g" )
				let l:line = substitute( l:line, escape( s:comment_stopbak, '\*^$.~[]' ), s:comment_stop, "g" )
			endif
			call setline( l:midline, l:pad . l:line )
		endif
		let l:midline = l:midline + 1
	endwhile
	" look at line above block
	let l:indent = indent( l:firstln - 1 ) / &tabstop
	let l:line = getline( l:firstln - 1 )
	" abandoned begin comment block line - delete line
	if strpart( l:line, l:indent ) == s:comment_strt . s:comment_pad
		execute ( l:firstln - 1 ) . "d"
		let l:firstln = l:firstln - 1
		let l:lastln = l:lastln - 1
	" abandoned commented code line - insert end comment block line
	elseif strpart( l:line, l:indent, l:clen ) == s:comment_mid0
		let l:pad = strpart( l:line, 0, l:indent )
		call append( l:firstln - 1, l:pad . s:comment_mid1 . s:comment_pad . s:comment_stop )
		let l:lastln = l:lastln + 1
	endif
	" look at line belowe block
	let l:indent = indent( l:lastln + 1 ) / &tabstop
	let l:line = getline( l:lastln + 1 )
	" abandoned end comment block line - delete line
	if strpart( l:line, l:indent ) == s:comment_mid1 . s:comment_pad . s:comment_stop
		execute ( l:lastln + 1 ) . "d"
		let l:lastln = l:lastln - 1
	" abandoned commented code line - insert begin comment block line
	elseif strpart( l:line, l:indent, l:clen ) == s:comment_mid0
		let l:pad = strpart( l:line, 0, l:indent )
		call append( l:lastln, l:pad . s:comment_strt . s:comment_pad )
	endif
endfunction

