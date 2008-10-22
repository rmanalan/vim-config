autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,perl,tex set shiftwidth=2
 
autocmd FileType c,cpp,java,javascript,python,xml,xhtml,html set shiftwidth=2
 
augroup filetypedetect
	au! BufNewFile,BufRead *.ch setf cheat
	au BufNewFile,BufRead *.liquid setf liquid
	au! BufRead,BufNewFile *.haml setfiletype haml
	autocmd BufNewFile,BufRead *.yml setf eruby
augroup END
 
autocmd BufNewFile,BufRead *_test.rb source ~/.vim/ftplugin/shoulda.vim
"use \rci in normal mode to indent ruby code,should install kode ,sudo gem
"install kode
nmap <leader>rci :%!ruby-code-indenter<cr>
 
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" Load matchit (% to bounce from do to end, etc.)
runtime! plugin/matchit.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible          " We're running Vim, not Vi!
"set gfn=Bitstream\ Vera\ Sans\ Mono:h11
set guifont=Monaco:h10
set guitablabel=%M%t
set nobackup
set nowritebackup
set path=$PWD/public/**,$PWD/**
filetype plugin indent on " Enable filetype-specific indenting and plugins
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set guioptions-=m
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,%n%Y%)\%P
set laststatus=2
map <C-q> :mksession! ~/.vim/.session <cr>
map <C-w> :tabclose<CR>
map <C-//> map ,# :s/^/#/<CR>
map <S-//> :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR><Esc>:nohlsearch<CR>
imap <M-Up> :tabn<CR>
imap <M-Down> :tabp<CR>
source $VIMRUNTIME/mswin.vim
"so ~/.vim/plugin/supertab.vim
imap <c-s> <esc><c-s>
set guioptions-=T
if has("gui_running")
    set transparency=7
    colorscheme vibrantink
    set lines=45
    set columns=115
    syntax on                 " Enable syntax highlighting
    set noantialias
else
"    set term=ansi
    syntax on
endif

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim
set nonumber

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END
let g:proj_flags="imstg"
nmap <silent> <Leader>p :NERDTreeToggle<CR>
map <leader>t :FuzzyFinderTextMate<CR>
let g:fuzzy_ceiling=50000
let g:fuzzy_match_limit=25

