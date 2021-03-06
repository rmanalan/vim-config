"
"   You will have to restart vim for this to take effect.  In any case
"   it is a good idea to read ":he new-filetype" so that you know what
"   is going on, and why the above lines work.
"
"   Written originally by Dominic Mitchell, Jan 2006.
"   happygiraffe.net
"
"   Modified by Aaron Bieber, May 2007.
"   blog.aaronbieber.com
"
" @(#) $Id$

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

" Textile commands like "h1" are case sensitive, AFAIK.
syn case match

" Textile syntax: <http://textism.com/tools/textile/>

" Block elements.
syn match txtHeader      /^h[1-6]\./
syn match txtBlockquote  /^bq\./
syn match txtFootnoteDef /^fn[0-9]\+\./
syn match txtListBullet  /^\*\+/
syn match txtListNumber  /^#\+/

syn cluster txtBlockElement contains=txtHeader,txtBlockElement,txtFootnoteDef,txtListBullet,txtListNumber

" Inline elements.
syn match txtEmphasis    /_[^_]\+_/
syn match txtBold        /\*[^*]\+\*/
syn match txtCite        /??.\+??/
syn match txtDeleted     /-[^-]\+-/
syn match txtInserted    /+[^+]\++/
syn match txtSuper       /\^[^^]\+\^/
syn match txtSub         /\~[^~]\+\~/
syn match txtSpan        /%[^%]\+%/
syn match txtFootnoteRef /\[[0-9]\+]/
syn match txtCode        /@[^@]\+@/

" Everything after the first colon is from RFC 2396, with extra
" backslashes to keep vim happy...  Original:
" ^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?
"
" Revised the pattern to exclude spaces from the URL portion of the
" pattern. Aaron Bieber, 2007.
syn match txtLink /"[^"]\+":\(\([^:\/?# ]\+\):\)\?\(\/\/\([^\/?# ]*\)\)\?\([^?# ]*\)\(?\([^# ]*\)\)\?\(#\([^ ]*\)\)\?/

syn cluster txtInlineElement contains=txtEmphasis,txtBold,txtCite,txtDeleted,txtInserted,txtSuper,txtSub,txtSpan

syn match yamlDelimiter	"[:,-]"
syn match yamlBlock "[\[\]\{\}\|\>]"
syn match yamlOperator "[?^+-]\|=>"

syn region yamlComment	start="\#" end="$"
syn match yamlIndicator	"#YAML:\S\+"

syn region yamlString	start="'" end="'" skip="\\'"
syn region yamlString	start='"' end='"' skip='\\"' contains=yamlEscape
syn match  yamlEscape	+\\[abfnrtv'"\\]+ contained
syn match  yamlEscape	"\\\o\o\=\o\=" contained
syn match  yamlEscape	"\\x\x\+" contained

syn match  yamlType	"!\S\+"

syn keyword yamlConstant NULL Null null NONE None none NIL Nil nil
syn keyword yamlConstant TRUE True true YES Yes yes ON On on
syn keyword yamlConstant FALSE False false NO No no OFF Off off

syn match  yamlKey	"\w\+\ze\s*:"
syn match  yamlAnchor	"&\S\+"
syn match  yamlAlias	"*\S\+"

" Setupt the hilighting links

hi link yamlConstant Keyword
hi link yamlIndicator PreCondit
hi link yamlAnchor	Function
hi link yamlAlias	Function
hi link yamlKey		Identifier
hi link yamlType	Type

hi link yamlComment	Comment
hi link yamlBlock	Operator
hi link yamlOperator	Operator
hi link yamlDelimiter	Delimiter
hi link yamlString	String
hi link yamlEscape	Special

if version >= 508 || !exists("did_txt_syn_inits")
    if version < 508
        let did_txt_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif

    HiLink txtHeader Title
    HiLink txtBlockquote Comment
    HiLink txtListBullet PreProc
    HiLink txtListNumber PreProc
    HiLink txtLink String
    HiLink txtCode Identifier
    hi def txtEmphasis term=underline cterm=underline gui=italic
    hi def txtBold term=bold cterm=bold gui=bold

    delcommand HiLink
endif

" vim: set ai et sw=4 :
