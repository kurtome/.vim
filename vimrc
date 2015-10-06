"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Orignal taken from:
"       http://amix.dk/blog/post/19486#the-ultimate-vim-configuration-vimrc
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"======================"
" Vundle configuration "
"======================"

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
if isdirectory(expand('$HOME/.vim/bundle/Vundle.vim'))
  call vundle#begin()
  " Required
  Plugin 'gmarik/vundle'
  " Install plugins that come from github.  Once Vundle is installed, these can be
  " installed with :PluginInstall
  Plugin 'scrooloose/nerdcommenter'
  Plugin 'bling/vim-airline'
  Plugin 'scrooloose/nerdtree'
  Plugin 'kien/ctrlp.vim'
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-notes'
  Plugin 'Valloric/MatchTagAlways'
  Plugin 'vim-scripts/netrw.vim'
  Plugin 'tpope/vim-sensible'
  Plugin 'SirVer/ultisnips'
  " Provide many default snippets for a variety of snippets.
  " Uncomment and :PluginInstall to enable
  " Plugin 'honza/vim-snippets'

  call vundle#end()
else
  echomsg 'Vundle is not installed. You can install Vundle from'
      \ 'https://github.com/VundleVim/Vundle.vim'
endif

filetype plugin indent on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" system type definition
fun! Mysys()
    return "linux"
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sets how many lines of history vim has to remember
set history=700

" allow dirty buffers to exist while hidden
set hidden

" enable filetype plugin
filetype plugin on
filetype indent on

" set to auto read when a file is changed from the outside
set autoread

" with a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" fast saving
nmap <leader>w :w!<cr>

" fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" when vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set 7 lines to the curors - when moving vertical=

set wildmenu "turn on wild menu

set ruler "always show current position

set cmdheight=2 "the commandbar height

set hid "change buffer - without saving

" set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "ignore case when searching
set smartcase " except when upper case is used in the search term

set hlsearch "highlight search things

set incsearch "make search act like search in modern browsers
set nolazyredraw "don't redraw while executing macros 

set magic "set magic on, for regular expressions

set showmatch "show matching brackets when text indicator is over them
set mat=2 "how many tenths of a second to blink

" no sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" => colors and fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "enable syntax hl

" set font according to system
if Mysys() == "mac"
  set gfn=menlo:h14
  set shell=/bin/bash
elseif Mysys() == "windows"
  set gfn=bitstream\ vera\ sans\ mono:h10
elseif Mysys() == "linux"
  set gfn=monospace\ 10
  set shell=/bin/bash
endif

syntax enable
colorscheme solarized
set background=dark

set t_Co=256
" tell Solarized to use the <t_co> degraded color mode
let g:solarized_termcolors=256


if has("gui_running")
    set lines=55
    set columns=114
    set guioptions-=t
else
    " do terminal specific stuff
endif

set encoding=utf8
try
    lang en_us
catch
endtry

set ffs=unix,dos,mac "default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn backup off, since most stuff is in svn, git anyway...
set nobackup
set nowb
set noswapfile

"persistent undo
try
    if Mysys() == "windows"
      set undodir=c:\windows\temp
    else
      set undodir=~/.vim/undodir
    endif

    set undofile
catch
endtry

" shift U for re-dos
noremap U <c-r>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noexpandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "auto indent
set si "smart indet
set wrap "wrap lines


""""""""""""""""""""""""""""""
" => visual mode related
""""""""""""""""""""""""""""""
" really useful!
"  in visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call Visualsearch('f')<cr>
vnoremap <silent> # :call Visualsearch('b')<cr>

" when you press gv you vimgrep after the selected text
vnoremap <silent> gv :call Visualsearch('gv')<cr>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! Cmdline(str)
    exe "menu foo.bar :" . a:str
    emenu foo.bar
    unmenu foo
endfunction 

" from an idea by michael naumann.
function! Visualsearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^m"
    elseif a:direction == 'gv'
        call Cmdline("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^m"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" smart mappings on the command line
cno $h e ~/
cno $d e ~/desktop/
cno $j e ./
cno $c e <c-\>eCurrentfiledir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <c-\>eDeletetillslash()<cr>

" bash like keys for the command line
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-k> <c-u>

cnoremap <c-p> <up>
cnoremap <c-n> <down>

" useful on some european keyboards
map ½ $
imap ½ $
vmap ½ $
cmap ½ $


func! Cwd()
  let Cwd = getcwd()
  return "e " . Cwd
endfunc

func! Deletetillslash()
  let g:cmd = getcmdline()
  if Mysys() == "linux" || Mysys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if Mysys() == "linux" || Mysys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc

func! Currentfiledir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Move within wrapped lines
nnoremap j gj
nnoremap k gk

" moving between buffers
map <M-left> :bp<cr>
map <c-m-h> :bp<cr>

map <C-right> :bn<cr>
map <M-right> :bn<cr>
map <c-m-l> :bn<cr>

" close the current buffer
map <leader>bq :Bclose<cr>

" close all the buffers
map <leader>ba :1,300 bd!<cr>

" tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

" when pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" quick way to select all
nnoremap <leader>a ggVG


command! Bclose call Bufclosecloseit()
function! Bufclosecloseit()
   let l:currentbufnum = bufnr("%")
   let l:alternatebufnum = bufnr("#")

   if buflisted(l:alternatebufnum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentbufnum
     new
   endif

   if buflisted(l:currentbufnum)
     execute("bdelete! ".l:currentbufnum)
   endif
endfunction

" specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => windows
""""""""""""""""""""""""""""""
" resize current buffer by +/- 5 
nnoremap <C-left> :vertical resize -5<cr>
nnoremap <C-down> :resize +5<cr>
nnoremap <C-up> :resize -5<cr>
nnoremap <C-right> :vertical resize +5<cr>

""""""""""""""""""""""""""""""
" => statusline
""""""""""""""""""""""""""""""
" always hide the statusline
set laststatus=2

" format the statusline
set statusline=\ %{Haspaste()}%f%m%r%h\ %w\ \ Cwd:\ %r%{Curdir()}%h\ \ \ line:\ %l/%l:%c


function! Curdir()
    let curdir = substitute(getcwd(), '/users/amir/', "~/", "g")
    return curdir
endfunction

function! Haspaste()
    if &paste
        return 'paste mode  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>

" map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>o
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => general abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %h:%m:%s")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"remap vim 0
map 0 ^

"move a line of text using alt+[jk] or comamnd+[jk] on mac
nmap <m-j> mz:m+<cr>`z
nmap <m-k> mz:m-2<cr>`z
vmap <m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <m-k> :m'<-2<cr>`>my`<mzgv`yo`z

if Mysys() == "mac"
  nmap <d-j> <m-j>
  nmap <d-k> <m-k>
  vmap <d-j> <m-j>
  vmap <d-k> <m-k>
endif

"delete trailing white space, useful for python ;)
func! Deletetrailingws()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd bufwrite *.py :call Deletetrailingws()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" do :help cope if you are unsure what cope is. it's super useful!
map <leader>cc :botright cope<cr>
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>


""""""""""""""""""""""""""""""
" => bufexplorer plugin
""""""""""""""""""""""""""""""
let g:bufexplorerdefaulthelp=0
let g:bufexplorershowrelativepath=1
map <leader>o :bufexplorer<cr>


""""""""""""""""""""""""""""""
" => minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplvsplit = 25
let g:miniBufExplsplitbelow=1

let g:bufexplorersortby = "name"

autocmd bufread,bufnew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd filetype css set omnifunc=csscomplete#completecss


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au filetype python syn keyword pythondecorator true none false self

au bufnewfile,bufread *.jinja set syntax=htmljinja
au bufnewfile,bufread *.mako set ft=mako

au filetype python inoremap <buffer> $r return 
au filetype python inoremap <buffer> $i import 
au filetype python inoremap <buffer> $p print 
au filetype python inoremap <buffer> $f #--- ph ----------------------------------------------<esc>fp2xi
au filetype python map <buffer> <leader>1 /class 
au filetype python map <buffer> <leader>2 /def 
au filetype python map <buffer> <leader>c ?class 
au filetype python map <buffer> <leader>d ?def 


""""""""""""""""""""""""""""""
" => javascript section
"""""""""""""""""""""""""""""""
" au filetype javascript call Javascriptfold()
au filetype javascript setl fen
au filetype javascript setl nocindent

au filetype javascript imap <c-t> ajs.log();<esc>hi
au filetype javascript imap <c-a> alert();<esc>hi

au filetype javascript inoremap <buffer> $r return 
au filetype javascript inoremap <buffer> $f //--- ph ----------------------------------------------<esc>fp2xi

function! Javascriptfold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldbraces start=/{/ end=/}/ transparent fold keepend extend

    function! Foldtext()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=Foldtext()
endfunction




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>
au bufread,bufnewfile ~/buffer iab <buffer> xh1 ===========================================

set number
set numberwidth=5

set so=4


" use » to mark Tabs and ° to mark trailing whitespace. This is a
" non-obtrusive way to mark these special characters.
set list listchars=tab:»\ ,trail:°

" All kinds of good ways to return to normal mode
inoremap jj <esc>
inoremap kk <esc>

" Source a secondary vimrc file for setting specific to this machine.
if filereadable($HOME.'/.vimrc_local')
  source ~/.vimrc_local
endif

" Reload
nnoremap <leader>r :e<cr>
nnoremap <f5> :e<cr>

nnoremap <leader>p "0p




"""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""
" Start up NERDTree automatically
"autocmd vimenter * NERDTree
" If NERDTree is the only buffer open, let vim quit
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeWinSize=20

nnoremap <Leader>n :NERDTreeTabsToggle<CR>


""""""""""""""""""""""""""""""
" => ctrl-p plugin
""""""""""""""""""""""""""""""
noremap <leader>f :CtrlP<cr>
noremap <leader>ff :CtrlP<cr>
noremap <leader>fb :CtrlPBuffer<cr>
noremap <leader>fr :CtrlPMRU<cr>
noremap <leader>fa :CtrlPMixed<cr>

" When ctrl-p opens multiple files, open up to 10 in new tabs
let g:ctrlp_open_multiple_files = '10tj'

" Allow many files to be indexed, (for big projects)
let g:ctrlp_max_files = 100000

" Ignore dot files and directories
let g:ctrlp_dotfiles = 0

" Dept to go to
let g:ctrlp_max_depth = 40

" Search by filename only (too many false postives with full path)
let g:ctrlp_by_filename = 1

" Wait half second after typing stopped before searching
let g:ctrlp_lazy_update = 500

""""""""""""""""""""""""""""""
" => vim grep
""""""""""""""""""""""""""""""
let grep_skip_dirs = 'rcs cvs sccs .svn generated'
set grepprg=/bin/grep\ -nh

"""""""""""""""""""""""""""""
" => vim airline
"""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme = 'solarized'


"""""""""""""""""""""""""
" => vim notes
"""""""""""""""""""""""""

let g:notes_directories = ['~/Documents/vim-notes']


