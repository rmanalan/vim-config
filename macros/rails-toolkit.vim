" railstoolkit.vim - default setup commands for vim. Part of the rails-toolkit
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

syntax on
filetype indent on
set shiftwidth=4 expandtab smarttab incsearch
augroup railstoolkit
  autocmd!
  autocmd FileType ruby,yaml,haml,sass set autoindent shiftwidth=2 softtabstop=2 expandtab number smarttab incsearch
augroup END
