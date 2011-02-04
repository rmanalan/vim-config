" Detect extra filetypes used in Rails. Part of the rails-toolkit
"
" Copyright (C) 2007 Neil Wilson <aldursys@gmail.com>
" "
" This program is free software; you can redistribute it and/or
" modify it under the terms of the GNU General Public License
" as published by the Free Software Foundation; either version 3
" of the License, or (at your option) any later version.
" 
" This program is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
" 
" You should have received a copy of the GNU General Public License
" along with this program.  If not, see <http://www.gnu.org/licenses/>.


if exists("did_load_filetypes")
    finish
endif
augroup filetypedetect
    au! BufRead,BufNewFile *.haml       setfiletype haml
    au! BufRead,BufNewFile *.ru       setfiletype ruby
augroup END

" markdown filetype file

if exists("did\_load\_filetypes")
 finish
endif

augroup markdown
 au! BufRead,BufNewFile *.md   setfiletype mkd
augroup END

